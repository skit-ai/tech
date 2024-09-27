---
title: Investigating Label Noise in intent classification datasets and fixing it
date: 2022-07-26
tags: [phone-number-capture-dataset]
categories: [Machine Learning]
image: assets/images/demo1.jpg
layout: post
authors: [anirudhthatipelli]
latex: True
fancy_audio_player: True
---

> This blog post is a dataset release for the Phone Number Entity capture task.

# Introduction

A bottleneck of a dialogue system is its ability to extract information from the utterances.  The information is extracted in the form of **frames**, that represents all the different types of intentions that the system can extract from user utterances and **slots**, that are the different type of possible values.

![image](https://user-images.githubusercontent.com/16001446/180951003-545b10f0-3762-4aad-bc45-d602e4d1a872.png)
For example, for the above conversation to book a flight, the frame will be of the type:

![image](https://user-images.githubusercontent.com/16001446/180951715-d0169425-8f17-443e-a823-23dff1e5af46.png)
# Motivation
Alphanumeric inputs are a combination of numbers and alphabets used as the identifier of users/customers/transactions and it is essential to capture these carefully for many industrial usecases like PNR numbers for airlines, PAN card numbers, Aadhar Card numbers. We can't input them as a DTMF input on the mobile keypad and there is a risk of confusion between phonetically similar letters when captured on voice. Additionally, it is challenging to capture these longer numerical inputs in one go without compromising the user experience.

The idea behind this dataset is to analyze the most suitable way to capture suc complex entities from a human speech. Humans can express such entities in different ways, ranging from small pauses within the utterance, to breaking the entity into smaller, simpler pieces. We explore two tracks capturing 2 (Indian English) speakers speaking out 75 phone numbers each:

1.  one track has phone numbers spoken in a single utterance, and
2. the other track has phone numbers split across two utterances with a (4,6) split of digits

The audios were recorded over a telephony line.

# Experiments

Using ASR, we can evaluate both the aforementioned tracks. We are concerned with the performance on the entity-capture task.

We want to evaluate the performance based on:

1. **System performance** - this is captured through entity and slot metrics. in the case of alphanumeric here, we focus on SER (Sentence Error Rate)
2. **User experience** - this is captured through a subjective UX score, assigned through analysis (by the CUX function)

We expect, system performance (≈SER) to be better for entities captured across two turns - since we are parsing smaller sub-entities independently and (naively) expect SER to be a function of CER (Character Error Rate) and length.

# Results

## Sentence Error Rate

Sentence Error Rate is a robust extension to WER(Word Error Metric), used to evaluate the working of an ASR system. 

We averaged the calculations across different callers, for each variation across different ASR systems.
![image](https://user-images.githubusercontent.com/16001446/180979426-e4ddc17f-a5e6-4af6-9659-e3f4e5166fac.png)

## UX Score
User testing was conducted with the CUX team of 20 users to understand the most natural way of providing the phone number (10 digits).

> Single Turn is a more natural way to collect a phone number than Two turns.

# Future Work
## Validate on a larger dataset

This is a small dataset. While the trends might be indicative, but the gaps they indicate are not reliable.

## Tune the parser for performance on sub-patterns

Sub-patterns are variations within a _sub-entity_. CUX analysis points to these being the fundamental unit of phone number utterances. So we should be tuning our parser (in this case an ASR with a tuned LM) for these patterns specifically.

There are two implementations this could support:

1.  **Single Turn** - assuming sub-entities are separated by pauses, we can parse each separately.
    
2.  **Two turns (any)** - here sub-entities are separted by turn, so we can naturally parse each separately

The dataset can be accessed at this  [link](https://github.com/skit-ai/phone-number-entity-dataset).

# References
1. [Speech and Language Processing](https://web.stanford.edu/~jurafsky/slp3/)

