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

Consider a restaurant booking voice bot built using a frames and slots approach.
While this can easily solve the problem with high automation accuracy, such
slot-filling framework can't carry on a meaningful conversation in a debate
unless you over-engineer the frames and slots to monstrous complexity. Booking a
restaurant is a form of conversation that's innately simpler than arguing with
someone in a debate competition. We can roughly say that these two conversations
lie in different complexity classes. In this first post of a series, we will lay
down a few factors that will help us define a map of conversations arranged
according to their complexities.

---

At Skit we build many kinds of task-oriented dialog systems for call center
automation. A very crude categorization of such systems, for us, is based on the
interaction with a sibling call handling system[^1] and the direction of
intention, user or agent initiation.

While we have used multiple approaches to measure difficulty of conversations
for our product delivery purposes, it's interesting to see if a purer framework
could be built around this. Similar to computational complexity, this can tell
us which problems are tractable under an algorithm. It can also help in
identifying the path towards the next generation of human machine conversational
systems.

We will cover a few thoughts around a few core constructs of the framework next.
First is the definition of success in a conversation, second around the
difficulty of doing so, and third about the algorithms and their complexities.

## Success

The definition of success of a conversation depends on alignment between goals
of the involved parties.

A regular goal oriented conversation with user initiation has a simple success
definition. For example, a call with user asking for temperature of a place can
be called successful if the temperature is provided. The metric here could be
something like the following:

$$ \text{Resolution%} = \frac{\text{Calls where user goals were met}}{\text{Total calls}} $$

This simple formulation becomes tricky as the alignment between user and bot
goals becomes inexact. For example when the _bot is calling_ the user for
payment reminders, it might not just want to remind and collect next reminder
time, but also want to persuade the users to pay as early as possible. In such
cases, you might want to use another rate for _favorable outcomes_:

$$ \text{Favorable%} = \frac{\text{Calls with favorable outcomes}}{\text{Resolved calls}} $$

Another example where this works is in _argumentative_ conversations where
holding a reasonable conversation and reaching conclusion is important
(_resolution_), but winning the argument (the favorable outcome) is what defines
success.

## Difficulty

We can look at difficulty of conversations from multiple levels. For the
smallest unit of dialog, a turn[^2], parsing and generating every utterance in a
conversation can be rated for difficulty. Here are a few factors that drive
difficulty for a turn:

1. Knowledge needed for understanding an entity. This could be general or
   specific to a situation, involving a connection with a dynamic or static
   knowledge source.
2. Speech Acts. Simpler acts like _greeting_ are easier to handle, while
   something like _pleading_ is hard.
3. Expression complexity, either intentional or unintentional.

But these are not sufficient since higher order behaviors across multiple turns
also make conversations difficult. As an example, consider negotiation for the
price in a market. In this situation, you need to use the conversational context
across turns to decide your next steps in a way that's harder than situations
where context dependency is lesser.

## Algorithms

The frameworks of developing, and running, voice bots are the last pieces that
will help us to map out the tractability of problems. A common method in the
industry is the frame-filling model that roughly needs learning _intents_ and
_entities_ for each utterance.

These frameworks or algorithms can be measured on their resource consumption. We
can start with sample complexity of conversations as the resource and create
statements like the following:

> Under framework $$f$$, you need an order of $$N$$ data points to supervise a
> voice bot of class $$k$$ to achieve a success rate of $$R(N)$$[^3].

This is non-surprising and is mappable to the statistical learning problem. What
is interesting is to see how we go ahead and define these classes and frameworks
which we will do in a later post.

[^1]: The sibling system could be non-existent, or backend human agents who can
    take over the more co plex conversations, or complex parts of running
    conversations.

[^2]: We can cover backchannel events also in a kind of _background_ turn.

[^3]: Including the other factors around PAC learning.
