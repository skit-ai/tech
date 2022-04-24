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

Despite going through many advances, the performance of speech dialogue systems remains unsatisfactory. For example, turn-taking is a fundamental aspect of
natural human conversation that helps to decide which participant has the floor in a conversation and who can speak next. Humans use many multimodal cues
like prosodic features, gaze, etc to determine who has the floor in a particular conversation. The interaction is very smooth with very less gaps and 
overalps between participants' speech, making the modelling difficult. Currently, dialogue systems use silence threshold to determine whether it should 
start speaking. This approach is too simplistic and can lead to issues. The system can interrupt the user mid-utterance, which is known as *cut-in*. Or 
the system waits for a long time and leads to sluggish responses and possible misrecognitions, which is known as *latency*. 

Before delving into end-of-utterance detection, it is imperative to get an understanding of turn-taking against which the end-of-utterance detection 
problem is based.

# Motivation

![image](https://user-images.githubusercontent.com/16001446/164992521-4e4242b7-9994-4625-b566-4a0a72317519.png)

A spoken dialogue system divides the complex task of conversing with the user into more specific subtasks handled by specialized components: voice 
activity detection, speech recognition, natural language understanding, dialog management, natural language generation, and speech synthesis. As systems
become more advanced, it is important that fundamental aspects like turn-taking are modelled in a more intuitive fashion.






## References

+ [Flexible Turn-Taking for Spoken Dialog Systems](https://www.lti.cs.cmu.edu/sites/default/files/research/thesis/2008/antoine_raux_flexible_turn-taking_for_spoken_dialog_systems.pdf)
+ [Turn-taking in Conversational Systems and Human-Robot Interaction: A Review](https://www.sciencedirect.com/science/article/pii/S088523082030111X)
+ [Rhythms of Dialogue.](https://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.384.968&rep=rep1&type=pdf)
