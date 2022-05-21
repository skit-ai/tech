---
title: Theory of Mind and Implications for Chatbots
date: 2022-05-19
tags: [chatbot, voice assistant]
categories: [Machine Learning, Theory of Mind]
layout: post
authors: [ojus1]
---
When a diplomat says _yes_, he means ‘perhaps’;  
When he says _perhaps_, he means ‘no’;  
When he says _no_, he is not a diplomat. 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;—_Voltaire_ (Quoted, in Spanish, in Escandell 1993.)

# Introduction

Consider this example: You're out in the street in a crowded area. A stranger walks upto you and asks for directions in your local language, *L*. You responded, you notice the facial expressions of the stranger and that they seem to be confused, and do not understand what you said. Now, you're confused as well, and try to clarify your instructions, but the stranger later reveals that he isn't very fluent in the language *L*; hence you ask for whether they understand a globally-used language *E*, the stranger confirms, and the conversation continues.

Let's breakdown what occurred here.
1. The stranger asked a question in a local language *L*.
2. You now have a belief that the stranger is speaks the local language *L*.
3. Due to your belief, you respond in the same language *L*, _expecting_ the stranger to understand the information you're trying to convey. This is a _false belief_, as it is later revealed.
4. You look for verbal/non-verbal cues from the stranger that they understood.
5. However, the stranger _denies_ your expectation by showing absence of such cues and instead, show cues of confusion.
6. You attempt to further elaborate your instructions taking these cues into account, however the stranger still seems confused.
7. The conversation at this point feels "awkward" since your expectations of the conversation were being denied multiple times.
8. The stranger reveals that they aren't very fluent in *L*.
9. This confirms that your _belief_ that the stranger understood *L* was _false_. This brings a sense of comfort since now you understand why your expectations were being denied.
10. You now correct for your _false belief_ and ask whether the stranger understands a globally-used language *E*.
11. The stranger confirms.
12. And the conversation continues.

This mechanism of having expectations from the other participant is a basis for successful conversation. If we lacked such an ability, the emergence of mutually accepted meanings of words, and language itself would be impossible. This also applies to non-verbal communication, such as body language and facial expressions, and to some degree, is observed in many animal species.

We now dive deeper into this aspect of communication, and formalize why both, human-human and human-machine conversations breakdown and/or lead to frustration of the participants.

# Theory of Mind

Whenever we converse, we take into account what we expect the other person to understand through our words as well as their possible responses. The ability to conceive such "theories" of other participants' mental states is termed as the Theory of Mind (ToM).

Having ToM requires the agent to acknowledge the fact that others (including the agent itself) can _believe_ in things which are not true. These beliefs are called _false beliefs_. An agent possessing ToM can identify their own as well as other's false beliefs and take actions to confirm and hence correct these false-beliefs.

# What makes a conversation _human-like_?

Proposition: 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; _A dialogue is human-like if both agents participating have some degree of Theory of Mind._

Theory of Mind is not limited to the content of the speech (such as the words spoken), but also addresses the mannerism of speech (prosody), facial and other non-verbal cues etc. It is easy to see that if any one of the agents lack ToM or have a poor ability, the conversation becomes uncomfortable and frustrating.

However, Theory of Mind is an acquired skill, expertise of humans on ToM matures over the lifespan [2], in-addition to depending on the amount of socialization the person part-takes in. This makes quantifying the degree of expertise over ToM difficult, hence quantifying the degree of _human-likeness_ is also difficult, in-addition to being be subjective. 

## Testing the Presence of Theory of Mind

Testing whether or not an agent is capable of modeling mental states of others is important for many reasons, one such application is diagonosing mental disorders. Such tests are called false-belief tasks. These tests check whether the agent can model other's false-beliefs and/or confirm and correct its own false-beliefs. We will discuss two popular false-belief tasks: "Sally-Anne" and "Smarties" tasks .

### Sally-Anne Task
![Illustration of the "Sally-Anne" Test](https://upload.wikimedia.org/wikipedia/en/a/ac/Sally-Anne_test.jpg)

The participating agent is told the following scenario:
1. Sally and Anne are inside a room. 
2. Sally has a basket with one marble inside it.
3. Anne has an empty box with her.
4. Sally leaves the room without her basket.
5. Anne takes the marble out of Sally's basket and puts it in her own box.
6. Sally comes back inside the room.

Now, the participant is asked, "Where will Sally look for her marble?". If the participant replies with "the basket", this means that the participant is able to model the mental state of a fictional character Sally, and that she doesn't know that Anne took her marble. Children below the age of 3-4 answer with "the box", however, older children answer with "the basket". Some children with mental disabilities such as Down syndrome and Autism are unable to pass this test.

### Smarties Task
Smarties is a popular brand of candies. 
1. The participant is presented with a box labelled "Smarties".
2. The participant is asked "what is in the box?".
3. The participant replies with "candies". 
4. The box is opened and is revealed that the box actually contains pencils. 
5. The participant is asked "What would someone else think is inside the box?". 
6. The participant passes the test if they respond with "candies".


Theory of Mind is an acquired skill, and is not innate, i.e., we aren't born with the ability to model other's mental states. A study [1] shows that children first pass False-belief tasks at around 3-4 years of age, around the same time as children first learn to tell lies, suggesting that learning to lie is a pre-cursor to possessing ToM. This does make sense, as lying would _only help if the other participant is capable of having false-beliefs_. Language and communication are also acquired skills.

## Theory of Mind: Relevance to Chatbots
Having ToM allows for certain mechanisms that would not be possible otherwise. Some are listed below:
1. The ability of the agent to recognize its own errors in perceiving (mis-hearing), i.e., discover its own false-beliefs and ask for clarifications. This also leads to a higher order reasoning capability of the agent.
2. The ability of the agent to dynamically model its counterpart throughout the conversation and adjust its own behaviour inorder to maximize the success of the dialog. Dynamic response and prosody generation, turn-taking, barge-in handling, etc. are such examples.

## Do Machines have a Theory of Mind?

One of the important goals of AI is to blend in the lives of Humans and solve problems _with humans-in-the-loop_, achieving this requires modeling humans and other machines around the agent, similar to how we humans do.

Some studies [3, 4] have shown that specially designed Multi-Agent Reinforcement Learning algorithms pass the Sally-Anne False-belief task. However, False-belief tasks have not been designed for/tested against chatbots. In this section, we test multiple Language Models (LM) against the Sally-Anne and Smarties tasks, and check whether they pass the tests or not. 

### Methodology
All of the experiments were done using Huggingface's Hub has inference interface. These experiments can be easily re-ran, however, it is not guarrenteed to get the same results since the inference is non-detereministic. The tasks are widely used and are available in Wikipedia and other scientific papers on which some/all of the LMs may have been trained on, hence these tests are not conclusive. 


#### Sally-Anne Task
Input Text: `Sally and Anne are inside a room. Sally has a basket with one marble inside it. Anne has an empty box with her. Sally leaves the room without her basket. Anne takes the marble out of Sally's basket and puts it in her own box. Sally comes back inside the room. Sally will look for her marble in `
If the LMs continue with `her basket`, `the basket` or anything similar, the LM passes the test, else it doesn't.

#### Smarties Task
Input Text: `Sally is presented with a box labeled "Candies". Sally is asked, "what is in the box?". Sally replies with "candies". The box is opened and is revealed that the box actually contains pencils. Sally is asked, "What would someone else think is in the box?". Sally answers `

If the LMs continue with `candies` or anything similar, the LM passes the test, else it doesn't.

### Results

| Language Model          | # Params | Sally-Anne | Smarties |
|-------------------------|----------|-----------|-----------|
| DistilGPT2              | 82M      | Fail      | Fail      |
| GPT-Neo-125M            | 125M     | Fail      | Fail      |
| GPT-Neo-1.3B            | 1.3B     | Fail      | Fail      |
| GPT-2                   | 1.5B     | Pass      | Pass      |
| GPT-Neo-2.7B            | 2.7B     | Pass      | Pass      |
| GPT-J-6B                | 6B       | Pass      | Pass      |

The largest three of the models pass both the tests. This suggests that scale might help LMs achieve some basic reasoning capabilities. This result is not surprising, since larger LMs usually do better in reasoning benchmarks.

P.S. The most entertaining response award goes to DistilGPT2 for `"I don't give a fig about the box"` for the Sally-Anne task. This is not made up, I swear!

## Implications for Goal-Oriented Chatbots

Open-domain chat has one important goal, _engagement with the user_. The user engages with the chatbot _if the chatbot is entertaining the user_. For this statement to hold true, the bot should appropriately make responses, which in-turn requires modeling the user, i.e., having a Theory of Mind. The _degree of engagement_ can be seen as a measure of _degree of ToM_ of the chatbot.

Testing ToM is straight-forward for Open-domain (chit-chat) chatbot. However, this is tricky for goal-oriented chatbots, as they are designed to handle dialog under a specific domain. False-belief task defined on one domain maybe out-of-domain for another domain.

Open-domain dialog is a strict generalization of goal-oriented dialog. However, goal-oriented may have goals which are defined differently from _engagement_. In many call-center settings, _call resolution_ is the most important goal. However, when voice chatbots are used in-place of human agents in call centers, a new and different behaviour of users arises: _call drop_. Users simply drop from the call if they:
1. get frustrated (due to mishearing, poor reasoning capabilities etc.).
2. think the chatbot is _incapable_ of answering their queries, even if the bot is capable. This is a false-belief of the user, and the chatbot is unable to correct the user's false-belief.
Call drops occur in a major chunk of the calls (40-50%).

Most chatbots in the industry are designed in a way that assumes _the user trusts the chatbot and has infinite patience_. Chatbot's behaviour is apparrently designed to optimize for resolving queries of the user, however, not to _inspire trust in the user that the bot is capable to resolve queries_.

There are two possible ways to "solve" this problem:
1. `Explicit`: Design the product in a way that inspires trust. Come up with the _best possible_ responses for all possible combination of dialog history and user states.
2. `Implicit`: Design the product in a top-down fashion rather than a bottom-up. Many believe that optimizing components with their local objective (Word-error-rate for ASR, F1 Scores for Intent classifiers etc.) would lead to a higher resolution rate. In biological systems, the higher-order function (survival) dictates lower order function (communication, language). Learning to communicate better can not ensure survival on its own. However, learning to survive _may lead to a better ability to communicate_. In other words, optimize ML models against objective (resolution rate) in-addition to the local objective. This _will_ force the chatbot to behave in a way that inspires trust from the user and effectively learn to have theory of mind of the users.

The first method is the industry standard, and it doesn't seem to be working well. The second method has the clear advantage of being data-driven and scalable.

# References
[1] Astington, J.W., & Edward, M.J. (2010). The Development of Theory of Mind in Early Childhood.

[2] Demetriou, A., Mouyi, A., & Spanoudis, G. (2010). "The development of mental processing", Nesselroade, J. R. (2010). "Methods in the study of life-span human development: Issues and answers." In W. F. Overton (Ed.), _Biology, cognition and methods across the life-span._ Volume 1 of the _Handbook of life-span development_ (pp. 36–55), Editor-in-chief: R. M. Lerner. Hoboken, New Jersey: Wiley.

[3] Rabinowitz, N.C., Perbet, F., Song, H.F., Zhang, C., Eslami, S.M., & Botvinick, M.M. (2018). Machine Theory of Mind. _ICML_.

[4] Nguyen, T.N., & González, C. (2020). Cognitive Machine Theory of Mind. _CogSci_.
