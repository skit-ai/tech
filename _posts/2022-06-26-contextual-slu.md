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
The bot prompts are a treasure-trove of contextual information. This information can be used to build better intent classification model. Few examples with the bot prompts and their intents are shown below:

|                                                                                 **Bot Prompt**                                                                                | **User Response** |        **Intent**        |
|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|:-----------------:|:------------------------:|
| Hi! I am Divya, your Hathway virtual assistant. Are you looking for a new Hathway Broadband connection?                                                                       | yes        | _confirm_new_connection_   |
| Okay!. To start with, please tell me if you are next to your Hathway device?                                                                                                  | I am              | _confirm_near_device_ |
| For how many people do you want to book the table for? | seven               | _number_guests_                  |



## Using Bot prompts as context
We curated a private dataset of clients wherein we collect user utterances along with all the bot prompts. 
We then concatenate the bot prompts with the user utterances. After retraining our intent classification model on some clients,
we observed a performance jump of **20-30%** in the intent-F1 scores. <br> 
This probably happened because our user prompts are not rich with enough information and
closing that information deficit via the bot prompts helped us achieve better performance. Another probable reason for such a huge jump could be probably because the transcription generated while using voice bots are less accurate as compared to a chat bot's transcription wherein a user types their response. As a result, the gap increment when supplied with contextual information when working with voice bots is much larger than let's say a bot. However, this was not the case with all our datasets. We observed that
the datasets with large number of classes didn't perform well or at par with datasets with less number of classes. One probable reason for it could be the dataset having
a large amount of granularity with respect to intents and as such there wasn't any significant bump in the performance.


<!-- We curate a private data of our clients wherein we collect user utterances along with all the bot prompts. Earlier, our systems
were dependent on solely using user utterances to build our Intent classifier but after conctenating bot prompts to our utterances, we
observed around 30% jump in our intent-F1 scores for some of our clients. -->

## Some probable approaches from literature

After observing an improvement in our models by just using a single bot prompt, we decided to a delve a bit further and found out many 
approaches that can be utilized for our use-case. While doing literature review, I observed that encoding the contextual prompt along with the user prompt gives the best performance amongst all the methods. The current approach of concatenating bot prompts with the user prompt acts as a natural baseline for our subsequent experiments in this direction. We discuss the encoding based approaches from the literature below:

### Encoding dialogue History [1, 2]
1. We can encode the complete dialogue history as shown below. Let us assume that the dialogue is
a sequence of $D_{t} = {u_{1}, u_{2}.. u_{t}}$ bot and user utterance and at every time 
step $t$ we are trying to output the classification for the user utterance $u_{t}$, given $D_{t}$.
We then divide the model into 2 components, the context encoder that acts on $D_{t}$ to produce
a vector representation of the dialogue context denoted by $h_{t} = H(D_{t})$ and the tagger, which takes
this context encoding $h_{t}$, and the current utterance $u_{t}$ as input and produces the intent output.

    <img src= '../assets/images/contextual/encoder_context.png' alt='drawing' width='600'>

2. Another approach is to have a different encoding mechanism for bot and user utterances [2]. This approach uses a system act encoder to obtain a vector representation $a^{t}$ of all system dialogue acts $A^{t}$. An utterance encoder is then used
to generate the user utterance encoding $u^{t}$ by processing the user utterance token embeddings $x^{t}$.
We then have a dialogue encoder that summarizes the content of the dialogue using $a^{t}$ and $u^{t}$, and its previous
hidden state $s^{t-1}$ to generate the dialogue context vector $o^{t}$, and also update the hidden state.
The dialogue context vector is then used for intent classification. Both the encoders use a hierarchical RNN that processes a single utterance at a time.

    <img src= '../assets/images/contextual/encoder_context_2.png' alt='drawing' width='600'>

## Conclusion
The above approaches and experiments show that context for SLU predictions can prove to be extremely useful for improving 
intent F1 scores. These above approaches are also not computationally expensive and can be easily deployed at scale for various use-cases.





## References
[1] Ankur Bapna, Gokhan Tür, Dilek Hakkani-Tür, and Larry Heck. 2017. Sequential Dialogue Context Modeling for Spoken Language Understanding. In Proceedings of the 18th Annual SIGdial Meeting on Discourse and Dialogue, pages 103–114, Saarbrücken, Germany. Association for Computational Linguistics. \
[2] Gupta, R., Rastogi, A., & Hakkani-Tür, D.Z. (2018). An Efficient Approach to Encoding Context for Spoken Language Understanding. ArXiv, abs/1807.00267.
