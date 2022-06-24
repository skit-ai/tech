---
title: Incorporating context to improve SLU
date: 2022-06-19
tags: [slu, context, nlp]
categories: [Machine Learning]
# image: assets/images/label-noise-blog/label-noise.png
layout: post
authors: [sanchit-ahuja]
latex: True
---

## Introduction
In task-oriented dialogue systems, the spoken language understanding, or SLU, refers to the task of parsing the natural language utterances into
semantic frames. The problem of contextual SLU majorly focuses on effectively incorporating dialogue information.


## Why context?
There are many in-scope intents that contain a lot of contextual information within the bot prompt and/or by using State-level information. Examples from one of our clients are below.
|                                                                                 **Bot Prompt**                                                                                | **User Response** |        **Intent**        |
|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|:-----------------:|:------------------------:|
| Hi! I am Divya, your Hathway virtual assistant. Are you looking for a new Hathway Broadband connection?                                                                       | yes** **          | confirm_new_connection   |
| Alright! To check your internet connectivity status, the device should be connected to the power supply and switched on. Will it be possible for you to switch on the device? | yes               | confirm                  |
| Okay!. To start with, please tell me if you are next to your Hathway device?                                                                                                  | I am              | confirm_near_device** ** |


Having that extra context from the bot can definitely help us to make a better contextual model.


## Using Bot prompts as context

We curate a private data of our clients wherein we collect user utterances along with all the bot prompts. Earlier, our systems
were dependent on solely using user utterances to build our Intent classifier but after conctenating bot prompts to our utterances, we
observed around 30% jump in our intent-F1 scores for some of our clients.

## Some probable approaches from literature

After observing an improvement in our models by just using a single bot prompt, we decided to a delve a bit further and found out many 
approaches that can be utilized for our use-case. We discuss a few of them below:

### Encoding dialogue History [1, 2]
1. We can encode the complete dialogue history as shown below. Let us assume that the dialogue is
a sequence of $D_{t} = {u_{1}, u_{2}.. u_{t}}$ bot and user utterance and at every time 
step $t$ we are trying to output the classification for the user utterance $u_{t}$, given $D_{t}$.
We then divide the model into 2 components, the context encoder that acts on $D_{t}$ to produce
a vector representation of the dialogue context denoted by $h_{t} = H(D_{t})$ and the tagger, which takes
this context encoding $h_{t}$, and the current utterance $u_{t}$ as input and produces the intent output.

    <img src= '../assets/images/contextual/encoder_context.png' alt='drawing' width='500'>

2. Another approach is to have a different encoding mechanism for bot and user utterances [2]. This approach uses a system act encoder to obtain a vector representation $a^{t}$ of all system dialogue acts $A^{t}$. An utterance encoder is used
to generate the user utterance encoding $u^{t}$ by processing the user utterance token embeddings $x^{t}$.
We then have a dialogue encoder that summarizes the content of the dialogue using $a^{t}$ and $u^{t}$, and its previous
hidden state $s^{t-1}$ to generate the dialogue context vector $o^{t}$, and also update the hidden state.
The dialogue context vector then is used for intent classification. Both the encoders use a hierarchical RNN that processes a single utterance at a time.

    <img src= '../assets/images/contextual/encoder_context_2.png' alt='drawing' width='500'>

## Conclusion
The above approaches and experiments show that context for SLU predictions can prove to be extremely useful for improving 
intent F1 scores. These above approaches are also not computationally expensive and can be easily deployed at scale for various use-cases.





## References
[1] Ankur Bapna, Gokhan Tür, Dilek Hakkani-Tür, and Larry Heck. 2017. Sequential Dialogue Context Modeling for Spoken Language Understanding. In Proceedings of the 18th Annual SIGdial Meeting on Discourse and Dialogue, pages 103–114, Saarbrücken, Germany. Association for Computational Linguistics. \
[2] Gupta, R., Rastogi, A., & Hakkani-Tür, D.Z. (2018). An Efficient Approach to Encoding Context for Spoken Language Understanding. ArXiv, abs/1807.00267.
