---
title: Building Fast and Efficient Microservices with gRPC
date: 2020-02-05
tags: [grpc, load balancing, microservices, interservice communication]
categories: [Engineering]
image: assets/images/posts/fast-microservices-with-grpc/highway.jpg
layout: post
authors: [mithun]
---

Vernacular.ai processes millions of speech recognition requests every day, and to handle such a load we have focused on building a highly scalable technical stack.

Firstly, we realized the drawbacks of using HTTP/1.1 keeping in mind one of our requirements to do end to end streaming recognition to reduce the overall latency of the system. So, we decided to migrate all our core services from REST APIs (HTTP/1.1 + JSON) to gRPC (HTTP/2.0 + Protobuf).

In this article, I will take you through the benefits and challenges of adopting gRPC when compared to a REST-based communication style.

## What is Microservices Architecture?

>
Defines an architecture that structures the application as a set of loosely coupled, collaborating services.

Services communicate using either synchronous protocols such as HTTP/REST, gRPC or asynchronous protocols such as AMQP. Services can be developed and deployed independently of one another.
>

## What are the challenges of adopting Microservices Architecture?

While there are many strong benefits of moving to a microservices architecture — there are no silver bullets!

This means there are tradeoffs to make!

Microservices gives us a higher level of complexity, and there are several inherent challenges with microservices you need to take into account when changing from a monolithic architecture. Like,

- Inter-service network communication
- Data serialization/de-serialization
- Security/Authentication
- Language Interoperability
- Streaming Data
- Monitoring
- Debugging

gRPC gives us the tools and capabilities to combat these issues without having to roll your custom frameworks.

## What is gRPC?

>
gRPC is a modern open-source high-performance RPC framework that can run in any environment. It can efficiently connect services in and across data centres with pluggable support for load balancing, tracing, health checking and authentication. It is also applicable in the last mile of distributed computing to connect devices, mobile applications and browsers to backend services.
>

## What are Protocol buffers?

>
Protocol Buffers, another open-source project by Google, is a language-neutral, platform-neutral, extensible mechanism for quickly serializing structured data in a small binary packet.
>

By default, gRPC used Protocol Buffers v3 for data serialisation.

When working with Protocol Buffers, we write a .proto file to define the data structures that we will be using in our RPC calls. This also tells protobuf how to serialise this data when sending it over the wire.

This results in small data packets being sent over the network, which keeps your RPC calls fast, as there are fewer data to transmit.

It also makes your code execute faster, as it spends less time serializing and deserializing the data that is being transmitted.

Here you can see, we are defining a Person data structure, with a name, an id and multiple phone numbers of different types.

```
syntax = "proto3";
message Person {
string name = 1;
    int32 id = 2;
    string email = 3;
    enum PhoneType {
      MOBILE = 0;
      HOME = 1;
      WORK = 2;
    }
    message PhoneNumber {
      string number = 1;
      PhoneType type = 2;
    }
    repeated PhoneNumber phone = 4;
}
```

Along with the data structures, we can also define RPC functions in the services section of our .proto file.

There are several types of RPC calls available — as we can see in GetFeature, we can do the standard synchronous request/response model, but we can also more advanced types of RPC calls, such as with RouteChat, where we can send information via bi-directional streams in a completely asynchronous way.

From these .proto files, we can use the gRPC tooling to generate both clients and server-side code that handles all the technical details of the RPC invocation, data serialisation, transmission and error handling.

This means we can focus on the logic of our application rather than worry about these implementation details.

```
service RouteGuide {
  rpc GetFeature(Point) returns (Feature);
  rpc RouteChat(stream RouteNote) returns (stream RouteNote);
}
message Point {
  int32 Latitude = 1;
  int32 Longitude = 2;
}
message Feature {
 string name = 1;
 Point location = 2;
}
message RouteNote {
  Point location = 1;
  string message = 2;
}
```

## gRPC (HTTP/2.0 + Protobuf) vs REST (HTTP/1.1 + JSON)

**HTTP/1.x**

HTTP/0.9 was a one-line protocol to bootstrap the World Wide Web

HTTP/1.0 documented the popular extensions to HTTP/0.9 in an informational standard.

HTTP/1.1 introduced an official IETF standard.

HTTP/1.x clients need to use multiple connections to achieve concurrency and reduce latency; HTTP/1.x does not compress request and response headers, causing unnecessary network traffic; HTTP/1.x does not allow effective resource prioritization, resulting in poor use of the underlying TCP connection; and so on.

**Advantages of HTTP/2.0**

The first advantage HTTP/2 gives you over HTTP/1.x is speed.

>
HTTP/2 reduces latency by enabling full request and response multiplexing, minimize protocol overhead via efficient compression of HTTP header fields, support for request prioritization, allows multiple concurrent exchanges on the same connection and server push.
>

<figure>
<center>
  <img alt="Can't See? Something went wrong!" src="/assets/images/posts/fast-microservices-with-grpc/http-2.png" />
  <figcaption>HTTP/2 vs HTTP/1.1 </figcaption>
</center>
</figure>

**Multiplexing — HTTP/1.1 vs HTTP/2.0**

HTTP/2 gives us multiplexing. Therefore, multiple gRPC calls can communicate over a single TCP/IP connection without the overhead of disconnecting and reconnecting over and over again as HTTP/1.1 will do for each request. This removes a huge overhead from traditional HTTP forms of communication.

<figure>
<center>
  <img alt="Can't See? Something went wrong!" src="/assets/images/posts/fast-microservices-with-grpc/traffic.png" />
</center>
</figure>

<figure>
<center>
  <img alt="Can't See? Something went wrong!" src="/assets/images/posts/fast-microservices-with-grpc/highway.png" />
</center>
</figure>

**Bi-directional Streaming**

HTTP/2 also has bi-directional streaming built-in. This means gRPC can send asynchronous, non-blocking data up and down, such as the RPC example we saw earlier, without having to resort to much slower techniques like HTTP-long polling.

A gRPC client can send data to the server and the gRPC server can send data to the client in a completely asynchronous manner.

This means that doing real-time, streaming communication over a microservices architecture is exceptionally easy to implement in our applications

**Multi-language support**

One of the big advantages of microservices architecture is using different languages for different services. gRPC works across multiple languages and platforms. Currently, these languages/frameworks are supported,

- Go
- Ruby
- PHP
- Java / Android
- C++
- C#
- Objective-C / iOS
- Python
- Node.js
- Dart

The best part is that gRPC is not just a library, but tooling as well. Once you have your .proto file defined, you can generate client and server stubs for all of these languages, allowing your RPC services to use a single API no matter what language they are written in!

This means that you can choose the right tool for the job when building your microservices — you aren’t locked into just one language or platform.

gRPC will generate clients and servers stubs that are canonically written for the language you want to use, and also take care of the serialisation and deserialisation of data in a way that your language of choice will understand!

There’s no need to worry about transport protocols or how data should be sent over the wire. All this is simply handled for you, and you can focus instead on the logic of your services as you write them.

<figure>
<center>
  <img alt="Can't See? Something went wrong!" src="/assets/images/posts/fast-microservices-with-grpc/grpc-stub.png" />
</center>
</figure>

This means that you can choose the right tool for the job when building your microservices — you aren’t locked into just one language or platform.

gRPC will generate clients and servers stubs that are canonically written for the language you want to use, and also take care of the serialisation and deserialisation of data in a way that your language of choice will understand!

There’s no need to worry about transport protocols or how data should be sent over the wire. All this is simply handled for you, and you can focus instead on the logic of your services as you write them.

## What are the challenges in adopting gRPC?

**Load Balancing**

Our microservices are containerized and deployed using [Kubernetes](https://kubernetes.io/), an open-source container orchestration system. Kubernetes’s default load balancing often doesn’t work out of the box with gRPC, we use [Linkerd](https://linkerd.io/2/getting-started/) (Service Mesh) for gRPC load balancing with sidecar container injected to existing pods.

More about [gRPC load balancing with Kubernetes](https://kubernetes.io/blog/2018/11/07/grpc-load-balancing-on-kubernetes-without-tears/) and other [gRPC load balancing options](https://grpc.io/blog/grpc-load-balancing/)

**Manual Testing**

Since gRPC is a binary protocol, the RPC methods cannot be manually tested using GUI tools like Postman (generally used for HTTP/1.1 text-based protocol). We have used [Evans](https://github.com/ktr0731/evans) REPL for gRPC introspection and manual testing.

To conclude, I would highly recommend everyone to try out gRPC and start migrating to gRPC in production.

If you are interested in working with cutting-edge technologies, come work with us. Apply [here](https://angel.co/company/vernacular-ai/jobs)