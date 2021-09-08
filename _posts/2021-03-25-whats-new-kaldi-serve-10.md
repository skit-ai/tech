---
title: What's New in Kaldi-Serve 1.0
date: 2021-03-25
tags: [speech recognition, framework, new release]
categories: [Machine Learning]
image: assets/images/demo1.jpg
layout: post
authors: [prabhsimran]
---

[Kaldi-Serve](https://github.com/skit-ai/kaldi-serve) is our open source high performance Speech Recognition server framework capable of serving [Kaldi ASR](https://github.com/kaldi-asr/kaldi) models in production environments for real-time inference, and it’s got an upgrade!


## What’s Changed?

Originally designed as a standalone application, kaldi-serve had some issues mostly pertaining to it’s usability or extensibility for custom use cases thus greatly reducing the core’s potential to just a handful of rigid situations and dependencies.

After one too many requests for changes in the architecture to better fit the various production needs of our customers, we realised it’s time for a rewrite of the framework that allows us to better utilise the core’s scope and extend it’s capabilities in the form of general API consumable in most use cases.

### Library

Kaldi-Serve is now a general extensible library with all the functionality necessary to serve Kaldi ASR models in production with any server framework of your choice, for ex. gRPC, Open CGI, HTTP, etc. or even import it in your own custom offline application.

The earlier standalone gRPC server is now and application that extends the core kaldi-serve library and only contains the frontend gRPC methods that call the general API. We’ll talk about how you can extend the library in your own applications below.

### Python Port

We also made it easier to use kaldi-serve by porting the core library to python which can be easily installed as a package via pip. The transcription interface is much simpler and faster to get up and running.

Below is sample code snippet for transcribing a wav file with your Kaldi Chain model using the kaldiserve python package:

```python
from io import BytesIO
from kaldiserve import ChainModel, Decoder, parse_model_specs, start_decoding

# chain model contains all const components to be shared across multiple threads
model = ChainModel(parse_model_specs("model-spec.toml")[0])

# initialize a decoder that references the chain model
decoder = Decoder(model)

# read audio file as bytes
with open("sample.wav", "rb") as f:
    audio_bytes = BytesIO(f.read()).getvalue()

with start_decoding(decoder):
    # decode the audio
    decoder.decode_wav_audio(audio_bytes)
    # get the n-best alternatives
    alts = decoder.get_decoded_results(10)

print(alts)
```


**More Features Coming Soon**
1. **Ontology**
2. **GPU Inference**
3. **MACE Integration**
