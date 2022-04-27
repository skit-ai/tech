---
title: End of Utterance Detection
date: 2022-04-24
tags: [end-of-utterance][turn-taking]
categories: [Machine Learning]
image: assets/images/demo1.jpg
layout: post
authors: [anirudhthatipelli]
latex: True
fancy_audio_player: True
---

> This blog post is based on the work done by [Anirudh 
> Thatipelli](https://github.com/Anirudh257) as an ML research fellow at Skit.ai

# End Of Utterance Detection - When does a speaker stop speaking?

End-of-utterance detection is the task of detecting when the user releases a floor after speaking an utterance.

![image](https://user-images.githubusercontent.com/16001446/164991645-fadf9a68-3e75-4077-8050-5aabdc30b2d1.png)

In the above image, there are four turns in total. The system initiates the conversation by speaking first ("How may I help you?"), then the user 
("I want to go to Miami."), then the system again ("Miami?") and finally the system ("Yes."). Empirically, the possession of a floor entirely depends on
the acoustic manifestation of the conversation, without regards to any linguistic or higher level aspect. 

> The speaker who utters the first unilateral sound both initiates the conversation and gains possession of the floor. Having gained possession, a speaker
maintains it until the first unilateral sounds by another speaker, at which time the latter gains possession of the floor.

Despite going through many advances, the performance of speech dialogue systems remains unsatisfactory. For example, turn-taking is a fundamental aspect of natural human conversation that helps to decide which participant has the floor in a conversation and who can speak next. Humans use many multimodal cues like prosodic features, gaze, etc to determine who has the floor in a particular conversation. The interaction is very smooth with very less gaps and overalps between participants' speech, making the modelling difficult. Currently, dialogue systems use silence threshold to determine whether it should start speaking. This approach is too simplistic and can lead to issues. The system can interrupt the user mid-utterance, which is known as *cut-in*. Or the system waits for a long time and leads to sluggish responses and possible misrecognitions, which is known as *latency*. 

Before delving into end-of-utterance detection, it is imperative to get an understanding of turn-taking against which the end-of-utterance detection 
problem is based.

# Motivation

![image](https://user-images.githubusercontent.com/16001446/164992521-4e4242b7-9994-4625-b566-4a0a72317519.png)

A spoken dialogue system divides the complex task of conversing with the user into more specific subtasks handled by specialized components: voice 
activity detection, speech recognition, natural language understanding, dialog management, natural language generation, and speech synthesis. As systems
become more advanced, it is important that fundamental aspects like turn-taking are modelled in a more intuitive manner.

A dialogue system designer should also consider the trade-offs between cut-ins and latency. For Skit, an effective turn-taking system will improve customer service and decrease call-drop rate.

One of the earliest models to study conversations was designed by Harvey Sacks in which he divided a conversation into two units of speech: **Turn-constructional units (TCU)** and **Transition-relevant place (TRP)** respectively. 

![image](https://user-images.githubusercontent.com/16001446/164993172-cc7293f1-5267-434a-9f77-a241b44a0421.png)

Turn-constructional units are utterances from one speaker during which other participants assume the role as listeners. And each TCU is followed by a 
TRP, where a turn-shift can occur by the following rules:

>1. The current speaker may select a next speaker (other-select), using for example gaze or an address term. In the case of
dyadic conversation, this may default to the other speaker.

>2. If the current speaker does not select a next speaker, then any participant can self-select. The first to start gains the turn.

>3. If no other party self-selects, the current speaker may continue.

To identify TCUs and TRPs, syntactic completion, prosody and non-verbal cues like eye-contact are useful. End of utterance task can be also defined as the detection of TRPs, i.e. when the user's turn is yielded and the system can start to speak. There are a multitude of works done in this regard, that 
can be divided into three types:

* Silence-based models. The end of the user’s utterance is detected using a VAD. A silence duration threshold is used to determine when to take the turn. 
As discussed above, this is too simplistic and can lead to misrecognitions.
* IPU-based models. Potential turn-taking points (IPUs) are detecting using a VAD. Turn-taking cues in the user’s speech are processed to determine whether the turn is yielded or not (potentially also considering the length of the pause).
* Continuous models. The user’s speech is processed continuously to find suitable places to take the turn, but also for identifying backchannel relevant places (BRP), or for making projections.

![image](https://user-images.githubusercontent.com/16001446/165028917-d3639f4c-8fa9-44d9-88ec-5dd0928f325a.png)

## IPU-based models

The system uses turn-taking cues at the end of pauses to determine whether a turn has ended. The approaches here run the gamut from hand-crafted rule-based semantic parsers to machine-learning and reinforcement learning techniques. 

Features based on semantics, syntax, dialogue state and prosody are used to classify whether a turn needs to be taken. Unlike fixed thresholds, the data-driven IPU models condition on the pause length to determine the probability of taking a turn. To improve performance of the turn-taking models on human-computer dialogue data, some approaches use bootstrapping. First, the data is manually annotated and suitable TRPs are recorded and trained via a suitable ML model. Many RL-based models have also been proposed where the turn-taking is modelled as a negotiative process and minimizes the dialogue duration. But these experiments are performed in simulated environments making it difficult to transfer to interactions with real-users. In addition, these approaches are too dependent on ASR's outputs.

## Continuous models

These approaches process the utterances in an incremental manner. The modules process the input frame-by-frame and pass their results to subsequent modules. This enables the system to make continuous TRP predictions, project turn completions and backchannels. The processing time is improved and the output becomes more *natural*. There is no need to explicitly train the model for end-of-turn detection. 

![image](https://user-images.githubusercontent.com/16001446/165454581-fceb250f-342f-4ca8-981d-bd635b922478.png)
[Towards a general, continuous model of turn-taking in spoken dialogue using LSTM recurrent neural networks](https://www.diva-portal.org/smash/get/diva2:1141130/FULLTEXT01.pdf) by Skantze process the audio from both the speakers in a frame-by-frame basis(20 frames per second) and use an LSTM to predict the speech activity for the two speakers for each frame in a future 3s window. 



## References

+ [Flexible Turn-Taking for Spoken Dialog Systems](https://www.lti.cs.cmu.edu/sites/default/files/research/thesis/2008/antoine_raux_flexible_turn-taking_for_spoken_dialog_systems.pdf)
+ [Turn-taking in Conversational Systems and Human-Robot Interaction: A Review](https://www.sciencedirect.com/science/article/pii/S088523082030111X)
+ [Rhythms of Dialogue.](https://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.384.968&rep=rep1&type=pdf)
+ [ simplest systematics for the organization of turn-taking for conversation.](https://pure.mpg.de/rest/items/item_2376846/component/file_2376845/content)
+ [Towards a general, continuous model of turn-taking in spoken dialogue using LSTM recurrent neural networks](https://www.diva-portal.org/smash/get/diva2:1141130/FULLTEXT01.pdf)
