---
title: Speech LLMs for Conversations
date: 2024-05-09
tags: [llm, speech, conversations]
categories: [Machine Learning]
layout: post
authors: [Shangeth, lepisma]
latex: True
---

With LLMs making conversational systems has become easier. You no longer need to
focus on the low-level details of categorizing semantics and designing
responses. Instead, you can concentrate on controlling high-level behaviors via
an LLM. This is the trend that we see most of the world moving towards as
products are using vendor combinations of ASR, LLM, and TTS with some dialog
management stitched in between. While this is going to be the norm soon, we want
to keep exploring areas from where the next set of quality improvements will
come.

[Earlier](/speech-first-conversational-ai-revisited/) we discussed how spoken
conversations are richer than pure text and how the gap would be not bridged by
LLMs purely working on transcriptions. In one of our recent experiments we build
an efficient multi-modal LLM that takes speech directly to provide better
conversational experience. For production usage, the constraint here is that
this should happen without losing the flexibility that you get in a text-only
LLM around writing prompts, making changes, evaluating, and debugging.

Below is a conversation with our recent in-house Speech LLM based conversational
system. Notice that because of the extra information in speech some micro
personalizations can happen like usage of gendered pronouns[^1]. You also get
lower impact of transcription errors and in general better responses in
non-speech signals. With access to both speech and text domains, the model
allows for more fluent turn-taking, though not demonstrated in the current
conversation. In addition, our approach also reduces the combined model size
(<2B) for taking speech to response, leading to lower compute latency as
compared to larger systems.

<style>
.webvtt-player .media {
  display: unset;
}

.webvtt-player .container {
  width: unset;
}

.webvtt-player {
  font-family: sans-serif;
  font-size: 0.8em;
}
</style>

<div id="webvtt-player"
     data-audio="../assets/audios/posts/speech-conversational-llms/audio.m4a"
     data-transcript="../assets/audios/posts/speech-conversational-llms/transcript.vtt"
     data-metadata="../assets/audios/posts/speech-conversational-llms/metadata.vtt" />

<script src="https://umd-mith.github.io/webvtt-player/webvtt-player.js"></script>

The model above doesn't yet control speech synthesis beyond the textual markers
it can generate, but that's something to be added soon (you might have noticed
erratic pitch shifts in the call above since TTS vendors don't contextualize
based on past conversations). Stay tuned for more details on how we take this
and similar research areas forward.

[^1]: Of course concerns around paralinguistic prediction accuracies are
    extremely important to take something like this in production.
