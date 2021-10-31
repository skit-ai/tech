---
title: Authentication in gRPC
date: 2021-10-31
tags: [authentication, gRPC]
categories: [Engineering]
image: assets/images/thumbnail-authentication-in-grpc.svg
layout: post
authors: [deepankar, ]
latex: True
---

In gRPC, there are a number of ways you can add authentication between client
and server. It is handled via Credentials Objects.

There are two types of credential objects:
1. **Channel Credentials**: These are handled on the channel level, i.e when
   the connection is established and a channel is created.
2. **Call Credentials**: These are handled on per request level, i.e for every
   RPC call that is made. These Credential objects can also be combined to
   create `CompositeChannelCredentials` with one Channel Credential and one
   Call Credential object.

Now let us see how we can use these credential objects.

## Client-Side TLS/SSL Authentication
gRPC provides a way to establish a connection without any secure connection i.e just like HTTP.

```go
// client.go
conn, _ := grpc.Dial("localhost:5000", grpc.WithInsecure())

// server.go
lis, err := net.Listen("tcp", ":5000")
s := grpc.NewServer()
s.Serve(lis)
```

For secure communication, we will create `TransportCredentials` which is a type
of `ChannelCredential` object.

```go
// client.go
creds, _ := credentials.NewClientTLSFromFile(certFile, "")
conn, _ := grpc.Dial("localhost:5000", grpc.WithTransportCredentials(creds))

// server.go
lis, _ := net.Listen("tcp", "localhost:50051")
creds, _ := credentials.NewServerTLSFromFile(certFile, keyFile)
s := grpc.NewServer(grpc.Creds(creds))
s.Serve(lis)
```

You can read more about generating own ssl certificates [here][ssl-certificates].

In the case where you don’t own the client, it means you are creating a gRPC
API for public use, you cannot give your certificate to everyone using your
client. In that case, we rely on well known [Certificate
Authority][certificate-authority] like LetsEncrypt, Amazon, etc. to generate a
certificate. So let us change our client code a little.

```go
// client.go
config := &tls.Config{
  InsecureSkipVerify: false,
}
conn, err := grpc.Dial(address, grpc.WithTransportCredentials(credentials.NewTLS(config)))
// server code remains the same
```

In this case what happens is that grpc loads the certificates of well-known
Certificate Authorities from the OS and sends it to the server, hence no need
to manually provide a certificate.

## Token-Based Authentication / OAuth2

Many a time we want to differentiate a client by issuing them different tokens.
TLS Authentication is a good way to secure your connection but it does not tell
us from which client the request is coming from. We will send the token in
request metadata just like HTTP Headers.

gRPC has `google.golang.org/grpc/metadata` package to send and receive metadata
with a RPC request.

```go
// client.go

// add metadata to request context
md := metadata.Pairs("Authorization", "Bearer xxx-xxx-xxx")
ctx := metadata.NewContext(context.Background(), md)

// use this context to call rpc
_, err = client.CallRPC(ctx, requestObject)
```

We will use `UnaryInterceptor` on the server which acts as middleware and
checks for the token for all the requests.

```go
// create a middleware
func AuthInterceptor(ctx context.Context, req interface{}, info *grpc.UnaryServerInfo, handler grpc.UnaryHandler) (interface{}, error) {
    meta, ok := metadata.FromContext(ctx)
    if !ok {
      return nil, grpc.Errorf(codes.Unauthenticated, "missing context metadata")
    }
  
    // Take care: grpc internally reduce key values to lowercase
    if len(meta["authorization"]) != 1 {
        return nil, grpc.Errorf(codes.Unauthenticated, "invalid token")
    }

    if meta["authorization"][0] != "xxx-xxx-xxx" {
        return nil, grpc.Errorf(codes.Unauthenticated, "invalid token")
    }

    return handler(ctx, req)
}

// pass this when creating server
server := grpc.NewServer(
   grpc.UnaryInterceptor(AuthInterceptor),
)
```

But above code only works for non-streaming RPCs. For Streaming RPCs you can
implement `StreamInterceptor`. Instead of implementing it again you can use
this package. I hope this article helps you with authentication in gRPC.

If you are interested in working with cutting-edge technologies, come work with
[Skit][skit]. Apply [here][skit-openings].


[ssl-certificates]: https://www.linuxjournal.com/content/understanding-public-key-infrastructure-and-x509-certificates
[certificate-authority]: https://en.wikipedia.org/wiki/Certificate_authority
[skit]: https://skit.ai
[skit-openings]: https://skit.recruiterbox.com/
