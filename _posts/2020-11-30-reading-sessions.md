---
title: Reading Sessions
date: 2020-11-30
tags: [work]
categories: [Machine Learning]
image: assets/images/demo1.jpg
layout: post
authors: [lepisma]
---

Studying researches and building on top of them is an important part of what a
team of ML Engineers do on a regular basis. Usually, teams do this by organizing
periodic, often weekly, paper reading sessions. Here is a snippet from an
internal work memo by [Manas](https://github.com/janaab11/) explaining how we
look at these sessions:

> Lets start with the basic motivation behind these sessions - we want
> to read more papers. But beyond this individual goal, there is also
> the simpler driving force of enthusiasm - we read something we like,
> and we want to share it. It is the same instinct that drives us to
> talk about books we read, movies we watch, and podcasts we listen to.
> ...
>
> There are also secondary benefits, like knowledge transfer - both
> speaker and audience will understand the topic better after a good
> presentation - and discovering shared interests within a larger group,
> etc.

But it's not that easy to bring this in practice. Specially in a startup, where
processes and structures are constantly in flux. As the team size keeps growing,
different kinds of diversities start interfering. Diversities in interests,
reading styles, and even bandwidth.

This post covers how we organize reading sessions in the ML team at
[Skit.ai](https://skit.ai/). It might be helpful if you are trying
to do the same in your group.

------------------------------------------------------------------------

The very first thing that we did was to start asking people for research
papers that they like, weekly. After voting on one, the proposer of the
paper presented it on a predetermined day. This lost steam away after a
while because of various reasons. One of them being bandwidth crunch for
everyone that time. We were just 3 people.

We revived paper reading after a while. This time everyone picked and
presented a paper of their own liking. This wasn't supposed to scale up
with team size, but we went with this for a decent while. While we were
free to choose and read whatever we wanted, lack of continuity in
readings, practical disconnects and difference in interests started to
reduce the overall engagement.

After lockdown, the engagement level dropped further. On video calls,
you have to upgrade the quality of meetings if you want to maintain the
same level of participation. The missing modalities hurt significantly.
We spent inordinate amount of time trying to get to one single view on
how to go about these sessions. We tried experimenting with various
aspects like paper selection, accountability, presentation
accessibility, etc.

------------------------------------------------------------------------

Rather than going in those experiments in chronological order, it makes
sense to think about the problems from two angles based on what we know
now. You can say that the *sessions* are having certain issues, or
alternatively you can say that the *people* are having issues with the
sessions. While both feed on each other and are cyclic, it helps to look
at them separately.

## Sessions

We can break down sessions temporarily in the following three acts.

### 1. Pre Session

Here it's known that a certain session is supposed to happen. You can
do the following in preparation:

-   Set clear *expectations*. What is supposed to be covered? How it's
    supposed to be covered? Who should come? What will be the outcome?
    etc.
-   *Excite* the potential audience. If the audience is not really aware
    of the topic, some amount of pre-work needs to be done to pull them
    in.

### 2. Session

During the session, you want to:

-   Make the presentation *stimulating and engaging*.
-   Keep the presentation *accessible* while not being superficial.
-   Develop *practical connections* between the audience and content.

### 3. Post Session

Since you want the next sessions to be successful too, you would like
to:

-   Make sure people are going away with a healthy amount of *thought
    food*.
-   Nudge towards the *utilitarian aspects* of concepts discussed so that
    audience have a few threads of experimentation to follow in their day
    to day work.

## People

For people, we can think along the following lines[^1]:

-   Resourcefulness.
-   Motivation.
-   Interests, their depths, and varieties.
-   Style and method of working with new knowledge.
-   Level of comfort with group sessions. Both for presentation and
    discussion.
-   Bandwidth. Specially considering industrial settings like ours.
-   Structural assistance and pushes.

------------------------------------------------------------------------

Acting on all these factors to deliver a single style of session that
works for everyone is impossible. Not all factors might be important for
a team at a given moment of time, but even a reasonably small set is
sufficiently diverse. The key idea is accept a pluralistic view on the
issue. There is no *single* fundamentally correct way of doing these
sessions, and it's better to pick a digestible subset and solve for that.

Going ahead with this realization, we started doing *seminars*.

## Seminars

Reading Seminars are very similar to seminar courses in Universities.
From another internal memo:

> These \[Seminars\] exist to complement the world of *paper readings*.
> While *Paper Reading* sessions are about reading more papers and
> sharing what we like, *Reading Seminars* are about learning something
> specific. These are much more structured and pointed towards a goal.
> The idea is to have deeper discussions, over longer periods of time,
> about topics that might interest you. Either directly or indirectly,
> this will lead to a better output (from the speaker) and experience
> (for the audience) in the *Paper Reading* sessions that follow.

Seminars cover many of the issues nicely and they clearly don't touch
a few others. For example you can't just bring in any new paper and
discuss that in a session without setting up a seminar for that field.
And that's okay. There are other ways of handling that case.

At the moment, we have the following parallel seminars running:

-   Multi-Style TTS
-   End-to-End ASR
-   Speech Representation Learning
-   Dialog State Trackers
-   Computational Paralinguistics
-   Learning Theory

Each of these has a list of papers or topics to be discussed over a period of
1-2 months. While not perfect, these are turning out to be decent reading
roadmaps for these topics. Something we would like to open out after a couple of
months, similar to the old style
[paper reading](https://backyard.vernacular.ai/paper-reading/) sessions.

[^1]: Many are derived from an internal note by
    [Manas](https://github.com/janaab11/)
