---
title: Speech-First Conversational AI Revisited
date: 2023-05-11
tags: [speech, llm]
categories: [Machine Learning]
layout: post
authors: [lepisma]
latex: True
---

Around last year, [we shared our views](https://tech.skit.ai/speech-first-conversational-ai/) on how nuances of spoken conversations make voicebots different than chatbots. With the recent advancements in conversational technology, thanks to Large Language Models (LLMs), we wanted to revisit the implications on what we call Speech-First Conversational AI. This post is one of many such reexaminations.

We will try quoting the older blog post wherever possible, but if you haven’t read the older post, you are encouraged to [do so here](https://tech.skit.ai/speech-first-conversational-ai/) before going any further.

## What’s Changed?

In one line, the problem of having believable and reasonable conversations is solved with the current generation of LLMs. You would still get factual problems and minor niggles, but I could ask my grandmother to sit and chat with an LLM based text bot without breaking her mental model of how human conversations could happen, at all.

Internally, we use the phrase “text conversations are solved” to describe the impact of LLMs on our technology. But how does this reflect in spoken conversations? Will they also be solved? Sooner than later, sure. But there are some details to look in that go beyond raw textual models to do this well.

Beyond the statement of “text conversations are solved”, there are more upgrades that make us excited about their implications for spoken conversations. The most important being the hugely improved capability to model any behavior that can be *meaningfully-translated* in text. For example, if you want to do speech backchannel modeling right now, you might get very far by connecting a perception system with an LLM rather than building something else altogether. This pattern is part of the promises of AGI, and knowing that we are getting there gradually is very stimulating.

## Spoken Dialog

Let’s revisit the points that make spoken conversations different than textual ones, as described in [the post last year](https://tech.skit.ai/speech-first-conversational-ai/). In the main, all the points are still relevant, but the complexities involved in solutions are different now. As a Speech AI company, this is helping us get better answers to the question of how should we go about more natural interactions between humans and machines.

### 1. Signal

> Speech isn't merely a redundant modality, but adds valuable extra information. Different styles of uttering the same utterance can drastically change the meaning, something that's used a lot in human-human conversations.

This is still relevant and important. While speech recognition systems have started to become better in transcribing content, robust consumption of non-lexical content is still a problem to solve for doing *spoken conversations*.

One of our fresh research works (releasing soon) involves utilizing *prosodic* information along with lexical to increase language understanding and the *gain we got is still significant*.

### 2. Noise

Speech recognition systems have come a long way from 2022. WER performance, even in noisy audios, is extremely good and one could trust ASRs a lot more for downstream consumption than one could do last year.

More non-speech markers, timing information, etc. are accessible easily and accurately which could be clubbed with LLMs directly to simplify modeling behaviors like disfluencies.

### 3. Interaction Behavior

> We don't take turns in a half-duplex manner while talking. Even then, most dialog management systems are designed like sequential turn-taking state machines where party A says something, then hands over control to party B, then takes back after B is done. The way we take turns in true spoken conversations is more *full-duplex* and that's where a lot of interesting conversational phenomena happen.

> While conversing, we freely barge-in, attempt corrections, and show other backchannel behaviors. When the other party also starts doing the same and utilizing these both parties can have much more effective and grounded conversations.

Simulacrums of full duplex systems Google Duplex already have hinted at why this is important. While the product impact of full-duplex conversations has been elusive because of technology’s brittleness, with LLMs and better speech models, the practical viability of this is pretty high now.

A natural thread of work is modeling conversations speech to speech which is already happening in the research community. But even before perfecting that, we can significantly get better in spoken interactions with currently available technologies and some clever engineering.

### 4. Runtime Performance

> In chat conversations, model latencies and the variance over a sample don't impact user experience a lot. Humans look at chat differently and latency, even in seconds doesn't change the user experience as much as in voice.

> This makes it important for the voice stack to run much faster to avoid any violation of implicit contracts of spoken conversations.

This is something where heavy LLMs don’t do well natively. Large, high-quality models often require a GPU and optimization to meet speech latency requirements efficiently.

### 5. Personalization and Adaptation

> With all the extra added richness in the signals, the potential of personalization and adaptation goes up. A human talking to another human does many micro-adaptations including the choice of words (common with text conversations) and the acoustics of their voices based on the ongoing conversation.

> Sometimes these adaptations get ossified and form *sub-languages* that need different approaches for designing conversations. In our experience, people talking to voice bots talks in a different sub-language, a relatively understudied phenomenon.

As LLMs reduce the complexity and effort needed to model and design behaviors, we should get more product-level work on this in both textual and speech conversations. You might already see a bunch of AI talking heads, personas, etc. with the promise of adapting to *you*. Something like this was possible earlier but with much more effort than now.

### 6. Response Generation

With LLMs, the quality of responses content is extremely high and natural. And if they are not, you can always make them so by providing a few examples. Specifically for speech, LLMs are good substrate for modelling inputs to speech synthesis. Instead of hand-tuning SSMLs, we can now let an LLM model high-level markers to guide the right generation of spoken responses at the right time.

Additionally, similar to speech recognition, speech synthesis has got huge upgrades from last year. Systems like [bark](https://github.com/suno-ai/bark) provide a glimpse of the high quality of utterance along with the higher order control that could be driven by an LLM.

### 7. Development

This stays the same as before. Audio datasets still have more information than text and the maintenance burden is higher.

Though there is a general reduction of complexity in the language understanding side because of one model handling many problems together. Thus reducing annotation, system maintenance, and other related efforts.

## What’s Next?

With higher order emergent behaviors coming in LLMs, there is a general *lifting up* of problems that we solve in ML. All this has led to an unlocking of a sort where everyone is rethinking the limits of automation. For a product like ours—goal-oriented voicebots—we expect the reduction in modeling complexity to increase the extent of automation, even for dialogs that were considered forte of *human-agents.*

Technologically, the time is ripe to achieve great strides towards truly natural spoken conversations with machines. Something that was always undercut because of the, rightfully present, friction between user experience and technological limitations. Note that the definition of *natural* here still hangs on the evolving dynamics of human machine interactions, but we will see a phase transition for sure.
