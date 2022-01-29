---
title: Speech-First Conversational AI
date: 2022-01-21
tags: []
categories: [Machine Learning]
image: assets/images/demo1.jpg
layout: post
authors: [lepisma]
latex: True
fancy_audio_player: True
---

We often get asked about the differences between voice and chat bots. The most
common perception is that the voice bot problem can be reduced to chat bot after
plugging in a Speech to Text and Text to Speech system. We believe that's an
overly naive assumption about spoken conversations, even in goal-oriented dialog
systems. This post is an attempt to describe the differences involved and define
what _Speech-First_ Conversational AI means.

> Speech is the most sophisticated behavior of the most complex organism in the
> known universe. - [source](https://youtu.be/Zy3Ny-WjyGE?t=251)

Conversational AI systems solve problems of conversations, either using text or
voice. Since _conversations_ are specific to humans, there are many
anthropomorphic expectations from these systems. These expectations, while still
strong, are less restraining in text conversations as compared to speech. Speech
is deeply ingrained in human communication and minor misses could lead to
violation of user expectations. Contrast this with text messaging which is a,
relatively new, human-constructed channel[^1]. TODO

There are multiple academic sources on difference between speech and text, here
we will describing a few key differences that we have noticed while building
speech-first conversation systems:

## Input Signal

In addition to the textual content, speech signals contain information about the
user's state, trait, and the environment. Speech isn't merely a redundant
modality, but adds valuable extra information. Different style of uttering the
same utterance can drastically change the meaning, something that's used a lot
in human-human conversations.

Additionally, environmental factors including the recording quality, background
ambience, and audio events impact signals reception and semantics.

Once you go on transcribing audios utterances using ASRs, transcription errors
will add on to your burden. While ASRs systems are improving day-on-day, there
still is error potential in handling acoustically similar utterances.

## Conversation Behavior

With all the extra added richness in the signals, the potential of
personalization and adaptations goes up. A human talking to another human does
many micro-adaptations including the choice-of-words (common with text
conversations) and the acoustics of their voices based on the.

### Personalization and adaptations

+ Spoken languages tend to form sub-languages that need different approaches of
  processing. A person talking to a voice bot, talks in a different sub-language
  than in a situation where the conversation was with another human, even if the
  query is the same.
+ Response production has much more stake here as emotional signals and
  tonalities carry important weight.

Definition of responsiveness is drastically.

+ Responsiveness. Inter turn latency between human-human communication is
  extremely low and there is an unmentioned pact that makes it awkward if one
  party exceeds a certain time threshold.

Because of the interaction behavior, deviations from _fluent_ speech are not
just errors but develop their own pragmatic sense. Speech
[disfluencies](https://en.wikipedia.org/wiki/Speech_disfluency) are commonly
assumed behaviors of natural conversations and lack of them could even cause
discomfort.

## Development

Finally, working with audios is more difficult than text because of additional
and storage processing capabilities needed. Here is an audio utterance for the
text "1 2 3":

{% fancy_audio /assets/audios/posts/speech-first-conversational-ai/counts.wav %}

```
❯ file counts.wav  # 48.0 kB (48,044 bytes)
counts.wav: RIFF (little-endian) data, WAVE audio, Microsoft PCM, 16 bit, mono 8000 Hz
```

Compare this with just 6 bytes needed for the string itself (`echo "1 2 3" | wc
--bytes`).

---


[^1]: Epistolary communication aside.