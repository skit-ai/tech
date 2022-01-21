---
title: Speech First Conversational AI
date: 2022-01-21
tags: []
categories: [Machine Learning]
image: assets/images/demo1.jpg
layout: post
authors: [lepisma]
latex: True
---

We often get asked this question about why we are ...

Notes copied from another document below.

Conversational AI solves problems of conversations. Most of the systems are
designed to act as a human equivalent. Text messaging is a relatively new and
human constructed channel where users are habituated enough to understand the
processing model and tolerate behaviors stemming from limitations of technology.
For example if a typographical mistakes leads to wrong prediction, people are
considerate enough to notice and help them out. The same can't be said for
speech disfluencies.

> Speech is the most sophisticated behavior of the most complex organism in the
> known universe. - [source](https://youtu.be/Zy3Ny-WjyGE?t=251)

Speech is much deeply ingrained in human communication and a collective set of
minor details in how we hold conversations could lead to you violating user
expectations every moment if your system is not designed well.

Here are a few key differences why building speech-first conversation systems is
complex and involves much more than plugging an ASR and TTS over a text chatbot:

+ Responsiveness. Inter turn latency between human-human communication is
  extremely low and there is an unmentioned pact that makes it awkward if one
  party exceeds a certain time threshold.
+ Real world ASRs are noisy and the transcription you get might not be
  reflecting what the user actually said.
+ [Disfluency](https://en.wikipedia.org/wiki/Speech_disfluency) based errors.
  Unlike typographic errors, disfluencies are usually not considered as errors
  and the other party is assumed to be robust to them. In fact, they have a lot
  of impact on semantics of the utterance.
+ Speech contains a lot of signals about the user and their utterance, most of
  which have important contribution in the conversation and are not meaningless
  redundancies. Scope of and value addition from user personalization is much
  more here because of similar reasons.
+ Spoken languages tend to form sub-languages that need different approaches of
  processing. A person talking to a voice bot, talks in a different sub-language
  than in a situation where the conversation was with another human, even if the
  query is the same.
+ Environment has a huge impact on speech signals. This includes the ambience,
  the device that's doing the recording.
+ Response production has much more stake here as emotional signals and
  tonalities carry important weight.
+ Working with audios is more difficult than text because of the additional
  storage and processing complexities.

Working on speech-first dialog systems thus adds to the challenges already
present in a regular text, turn-based, chatbots.


