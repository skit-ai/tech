---
title: Complexity of Conversations - I
date: 2022-01-04
tags: []
categories: [Machine Learning]
image: assets/images/demo1.jpg
layout: post
authors: [lepisma]
latex: True
---

At Skit we build many kinds of task-oriented dialog systems for call center
automation. A very crude categorization of such systems, for us, is based on the
interaction with a sibling call handling system[^1] and the direction of
intention, user or agent initiation.

While we have used multiple approaches at multiple times to measure difficulty
of conversations for our product delivery purposes, it's interesting to see if a
purer framework could be built around this. In this first post of a series, we
will lay down a few factors that might help us define this in the future.

Why is measuring the difficulty of conversations important? Similar to
computational complexity, this can tell us which problems are tractable under an
algorithm. It also helps with identifying the gaps for us to focus on, so that
we can move towards the next generation of human machine conversational systems.

It's easy to establish differences. Consider a restaurant booking voice bot
built using a frames and slots approach. While this can easily solve the problem
with high automation accuracy, such slot-filling framework can't carry on a
meaningful conversation in a debate unless you over-engineer the frames and
slots to monstrous complexity. Booking a restaurant is a form of conversations
that's innately much simpler than arguing with someone in a high class debate
competition. You might find it hilarious to compare these two, but that's the
point, to map out the classes of conversations based on complexity and see what
it takes to design algorithms to solve the most challenging ones.

We will cover some thoughts around a few core constructs of the framework next.
First is the definition of success in a conversation, second around the
difficulty of doing so, and third about the algorithms and their complexities.

## Success

Different kinds of conversations would have different success definitions. Most
of these depend on alignment between goals of the two parties.

A regular goal oriented conversation with user initiation has a really simple
success definition. For example, a call with user asking for temperature of a
place can be called successful if the information is provided. The metric here
could be simple something like the following:

$$ \text{Resolution%} = \frac{\text{Calls where user goals were met}}{\text{Total calls}} $$

This simple formulation becomes tricky as the alignment between user and bot
goals becomes inexact. For example when the _bot is calling_ the user for
payment reminders, it might not just want to remind and collect a snooze time,
but also want to persuade the users to pay as early as possible. In such cases,
you might want to use another rate of favorable outcomes:

$$ \text{Favorable%} = \frac{\text{Calls with favorable outcomes}}{\text{Resolved calls}} $$

Another example where this works is in _argumentative_ conversations where
holding a reasonable conversation and reaching conclusion is important
(_resolution_), winning the argument (the favorable outcome) is the key part of
_success_.

## Difficulty

TODO ...

+ Turn and conversation level
+ Speech acts
+ Difficult accents
+ Entities or information being passed
+ World or other forms of knowledge

## Algorithms

Algorithms to solve the voice-bot problems covers the whole framework of
developing a bot to handle conversations. A common method in the industry is the
frame-filling model that roughly needs learning _intents_ and _entities_ for
each utterance. There are other methods that do better or worse in different
situations.

The most important resource constraint here is the developmental one, specially
sample complexity (or its equivalents). How many data points do you need to
supervise your voice bot for achieving a certain success rate.

Since conversations are _humanly_ entities, we can use a human—an intelligent
and resourceful one—as an upper limit[^2]. Such a human needs minimal
supervision about the situation, mostly the context, and is ready to run
conversations.

Depending on the class of conversation, each frame TODO


For development, a direct approach involves measuring sample complexity is a
good start, 


All these point to a potential map of categories of conversations that need
different solution framework. We will explore a set of hypothesis around that in
the next post.

[^1]: The sibling system could be non-existent, or backend human agents who can
    take over the more co plex conversations, or complex parts of running
    conversations.

[^2]: Resourcefulness makes the upper limit vague as one can create a more
    resourceful machine by accessing to all the digital content on the internet.
