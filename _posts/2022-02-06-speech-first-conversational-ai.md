---
title: Speech-First Conversational AI
date: 2022-02-06
categories: [Machine Learning]
layout: post
authors: [lepisma]
latex: True
fancy_audio_player: True
---

We often get asked about the differences between voice and chat bots. The most
common perception is that the voice bot problem can be reduced to chat bot after
plugging in an Automatic Speech Recognition (ASR) and Text to Speech (TTS)
system. We believe that's an overly naive assumption about spoken conversations,
even in restricted goal-oriented dialog systems. This post is an attempt to
describe the differences involved and define what _Speech-First_ Conversational
AI means.

> Speech is the most sophisticated behavior of the most complex organism in the
> known universe. - [source](https://youtu.be/Zy3Ny-WjyGE?t=251)

Conversational AI systems solve problems of conversations, either using text or
voice. Since _conversations_ are specific to humans, there are many
anthropomorphic expectations from these systems. These expectations, while still
strong, are less restraining in text conversations as compared to speech. Speech
is deeply ingrained in human communication and minor misses could lead to
violation of user expectations. Contrast this with text messaging which is a,
relatively new, human-constructed channel[^1] where expectations are different
and more lenient.

There are multiple academic sources on differences between speech and text, here
we will describing a few key differences that we have noticed while building
speech-first conversation systems in more practical settings.

## Signal

In addition to the textual content, speech signals contain information about the
user's state, trait, and the environment. Speech isn't merely a redundant
modality, but adds valuable extra information. Different style of uttering the
same utterance can drastically change the meaning, something that's used a lot
in human-human conversations.

Environmental factors like recording quality, background ambience, and audio
events impact signals' reception and semantics. Even beyond the immediate
environment, a lot of socio-cultural factors are embedded in speech beyond the
level they are in text chats. Because the signals are rich, the difficulty of a
few common problems across text and speech, like low-resource languages, is
higher.

## Noise

Once you go on transcribing audios utterances using ASRs, transcription errors
will add on to your burden. While ASR systems are improving day-on-day, there
still is error potential in handling acoustically similar utterances. Overall,
an entirely new set of problems like far-field ASR, signal enhancement, etc.
exist in spoken conversations.

Additionally many _noisy_ deviations from fluent speech are not mere errors but
develop their own pragmatic sense and convey strong meaning. Speech
[disfluencies](https://en.wikipedia.org/wiki/Speech_disfluency) are commonly
assumed behaviors of natural conversations and lack of them could even cause
discomfort.

## Interaction Behavior

We don't take turns in a half-duplex manner while talking. Even then, most
dialog management systems are designed like sequential turn-taking state
machines where party A says something, then hands over control to party B, then
takes back after B is done. The way we take turns in true spoken conversations
is more _full-duplex_ and that's where a lot of interesting conversational
phenomenon happen.

While conversing, we freely barge-in, attempt corrections, and show other
backchannel behaviors. When the other party also start doing the same and
utilizing these both parties can have much more effective and grounded
conversations.

Additionally, because of lack of a visual interface to keep the context, user
recall around dialog history is different and that leads to different flow
designs.

## Personalization and adaptations

With all the extra added richness in the signals, the potential of
personalization and adaptations goes up. A human talking to another human does
many micro-adaptations including the choice-of-words (common with text
conversations) and the acoustics of their voices based on the ongoing
conversation.

Sometimes these adaptations get ossified and form _sub-languages_ that need
different approaches of designing conversations. In our experience, people
talking to voice bots talks in a different sub-language, a relatively
understudied phenomenon.

## Response Generation

Similar to the section on input _signals_, the output _signal_ from the voice
bot is also (should also be) extremely rich. This puts a lot of stake in
response production for natural conversation. The timing and content of sounds,
along with their tones impart strong semantic and pragmatic sense to the
utterance. Clever use of these also drive the conversations in a more fruitful
direction for both parties.

Possibilities concerning this area of work is _extremely_ limited in text
messaging.

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

These differences lead to gaps that are difficult to bridge and that's what
keeps us busy at Skit. If these problems interest you, you should reach out to
us on [join@skit.ai](mailto:join@skit.ai).


[^1]: Epistolary communication aside.
