---
title: Evaluating an ASR in a Spoken Dialogue System
date: 2022-01-21
tags: [ASR, WER]
categories: [Machine Learning]
image: assets/images/evaluating-asr.jpg
layout: post
authors: [swarajdalmia]
latex: True
---

An ASR (automatic speech recognition) is an integral component of any voice bot. The most popular metric that is used to evaluate the accuracy of an ASR model is WER or the word error rate. In this blog, we discuss metrics that can be used to evaluate an ASR, their flaws and suggestions for improvement in the context of a conversational agent.

The ASR module takes as input a spoken utterance and outputs the most likely transcription. Most ASR’s output multiple alternatives with certain confidence scores. Some ASR’s including Kaldi’s implementations output N-Best alternatives in an order not necessarily reflective of the confidence. Some ASR systems output likelihood information of word sequences in the form of word-lattices or confusion networks [1] with probability information.

## What is WER ?

Word Error Rate measures the transcription errors, treating words as the smallest unit. It takes 2 inputs, the actual transcript and a hypothesis transcript.

There are two types of WER:
- Isolated word recognition (IWR-WER)
- Connected Speech Recognition (CSR-WER)

**Isolated Word Recognition WER**

This considers the words in isolation and is not based on any alignment. It simply measures the number of non-hits.

$$IWR-WER = 1-\frac{H}{N}$$

where,  
H = number of hits  
N = total matched I/O words

**Connected Speech Recognition WER**

This is calculated on the basis of alignment and uses the Levenshtein distance for words which measures the minimum edit distance. This is efficiently calculated using dynamic programming. It calculates the best alignment which minimises the number of substitutions, insertions and deletions necessary to map the actual transcript to the hypothesis transcript, giving equal weight to all the operations. WER is not input/output symmetric, as N is the total number of words in the actual transcripts.

$$CSR-WER = (I+S+D)/(N)$$ 

where,
I = insertions  
S = substitutions  
D = deletions  
N = total number of words in the actual transcript  

An example calculation of the best alignment to calculate the CSR WER is shown below.

<figure>
<center>
  <img alt="Can't See? Something went wrong!" src="/assets/images/posts/evaluating-asr/wer.png"/>
  <figcaption>Fig 1: Taken from Speech and Language Processing by Jurafsky and Martin [2].</figcaption>
</center>
</figure>

The CSR WER for the above hypothesis is = (6+3+1)/13 = 0.77

The upper bound of CSR WER is not 1, but $$\frac{max(N1, N2)}{N1}$$ where N1 is length of true transcripts and N2 is length of hypothesis transcript.

## Statistical Significance of WER ?

Improvements in WER’s over a test set is one of the standard ways of evaluating upgrades in an ASR. Often, what is missed out is in this evaluation is whether the gain is statistically significant or not. One of the standard statistical tests is the Matched-Pair Sentence Segment Word Error (MAPSSWE) test, introduced in Gillick and Cox (1989) [2]. For an example on how to calculate the statistic, consult the book by Jurafsky.  

## Issues with WER

- It gives the same importance to words like “a”, “the” compared to verbs and nouns that carry more semantic value.  
- WER is a purely 1 : 1 transcript based metric, and doesn’t take into account the rich output of ASR systems like alternatives or word lattices.  
- The concept of edit-distance that WER is based on is appropriate for a dictation machine where the additional cost is that of correcting the transcripts rather than applications where communicating the meaning is of primary importance    
- It doesn’t take into account the performance of an ASR in the context of the dialogue pipeline. For example if a higher WER makes no difference in the information retrieval for the downstream SLU then is the improvement worth it ?  
    - An example of a context dependent metric is discussed in [4].  
- It is not a true % based metric, because it has no upper bound therefore it doesn’t tell you how good a system is, but only that one is better than another. Even for the later, it provides only a heuristic for ranking of performance.  
    - Consider two ASR systems, ASR-1 that replaces 2 wrong words for every word it listens too, and another ASR system that replaces 1 wrong word for every word it listens to. Both communicate zero information, but the WER for ASR-1 is 2 and the WER for ASR-1 is 1. This 50% difference in WER is not reflective of performance, since both the systems communicate no correct information whatsoever.  

## Debunking Conventional Wisdom

One might assume that better ASR’s improve the performance of all downstream SLU systems. A paper in 2003 [7] found this was not always the case.  Their model had a 17% better slot accuracy despite a 46% worse WER performance. They have this gain by using a SLU model as the language model for speech recognition. Therefore it is not necessary that an oracular ASR will solve downstream inaccuracies. It is important to be aware that there might be non-linear correlations in metrics for the ASR vs the downstream task.

## WER Variants:

A few WER variants are discussed below.

Metrics that look at a different granularity than that of words :
****
- **Sentence Error Rate (SER)** : The percentage of sentences with at least one word error.
- **Character Error Rate (CER) :** Similar as WER with the smallest units as characters and not words

The next two error rates are variations of WER, are are bounded between [0,1].

- **Match Error Rate (MER)** [3] : Measures the probability of a given match being incorrect.

$$MER = \frac{I+S+D}{I+S+D+H} = 1 - \frac{H}{I+S+D+H}$$

where,  
H = number of hits
N = total number of words in the actual transcript  

MER is always <= WER.


- **Word Information Lost** **(WIL)** [3] : Information theoretic measure based on entropy. For more details look at the paper.

Example values, comparing WER, MER and WIL are shown below:

<figure>
<center>
  <img alt="Can't See? Something went wrong!" src="/assets/images/posts/evaluating-asr/mer.png"/>
  <figcaption>Fig 2: Taken from [3].</figcaption>
</center>
</figure>

Note : For implementations of WER, WIL, and MER, have a look at [Jiwer](https://pypi.org/project/jiwer/).

## Additional Error Analysis

Apart from looking at just single metrics for evaluating an ASR there are few additional metrics that one should use to evaluate a goal oriented ASR deployed for a given application:

- Which speaker demographic is most often misrecognised ?
- What (context-dependent) phones are least well recognised ?
- Which words are most confused ? Generate a confusion matrix of confused words.

These often help prioritise improvements in terms of what might benefit the goal the most.

# Semantics based Metrics

WER doesn’t look at the meaning of what has been transcribed despite the fact that is the semantics that are most relevant in an ASR that is a part of a spoken dialogue system.

## Concept accuracy

It is a simple metric that looks at the accuracy of the concepts that are of relevance in the transcripts.

Example:  
Reference - I want to go from Boston to Baltimore on September 29
Hypothesis - Go from Boston to Baltimore on December 29

The WER is $$45\%$$. However if one looks at concept accuracy, it is 2/3. Out of the 3 concepts : “Boston”, “Baltimore” and “September 29” it gets 2 of them right.

## WER with embeddings

In [this paper](https://hal.archives-ouvertes.fr/hal-01350102/file/metrics_correlation_asr-smt.pdf) [9] they look at augmenting the WER metric for an ASR that is used for a Spoken Language Translation (SLT) task.

They argue that some morphological operations, like adding a plural doesn't impact the translation task and that such substitution errors should be penalised differently. To decide which ones to penalise they use word embeddings. They call their new metric, WER-E i.e. WER with embeddings. The only change in this metric is that the substitution cost in WER is replaced by the cosine distance between the two words, so near identical words get assigned a very low cost.

## Other Metrics

There are lots of different papers that augment the WER metric or introduce a new metric specific to a downstream task. Mentioning a few of them below :

- In [10] a new measure called Automatic Transcription Evaluation for Named Entity (ATENE) is introduced for the NER downstream task
- 3 new evaluation metrics are introduced in [12], where the downstream application is Information Retrieval  
- SemDist metric is introduced in [13] for downstream SLU  

Downstream applications aside, it is quite pertinent to evaluate and benchmarks ASR across different social and demographic groups to evaluate bias and fairness. Systems don’t exist in isolation from the society in which they are deployed in and it is important that ML Engineers pay head to such metrics while deploying ASRs.

## References :

[1] : [N-Best ASR Transformer: Enhancing SLU Performance using Multiple ASR Hypotheses](https://arxiv.org/abs/2106.06519) (2021)
[2] [Speech and Language Processing (3rd ed. draft)](https://web.stanford.edu/~jurafsky/slp3/) by [Dan Jurafsky](http://web.stanford.edu/people/jurafsky/) and [James H. Martin](http://www.cs.colorado.edu/~martin/)
[3] : [From WER and RIL to MER and WIL: improved evaluation measures for connected speech recognition](https://www.researchgate.net/profile/Phil-Green-4/publication/221478089_From_WER_and_RIL_to_MER_and_WIL_improved_evaluation_measures_for_connected_speech_recognition/links/00b4951f95799284d9000000/From-WER-and-RIL-to-MER-and-WIL-improved-evaluation-measures-for-connected-speech-recognition.pdf) (2004)
[4] : [Automatic Human Utility Evaluation of ASR Systems: Does WER Really Predict Performance](https://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.412.4023&rep=rep1&type=pdf)? (2013)
[5] : http://www.cs.columbia.edu/~julia/courses/CS4706/asreval.pdf
[6] : [Meaning Error Rate: ASR domain-specific metric framework](https://dl.acm.org/doi/pdf/10.1145/3447548.3467372) (2021)
[7] : [Is word error rate a good indicator for spoken language understanding accuracy](https://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.89.424&rep=rep1&type=pdf) (2003)
[8] : [Automatic speech recognition errors detection and correction: A review](https://www.sciencedirect.com/science/article/pii/S1877050918302187) (2015)
[9] : [Better Evaluation of ASR in Speech Translation Context Using Word Embeddings](https://hal.archives-ouvertes.fr/hal-01350102/file/metrics_correlation_asr-smt.pdf) (2016)
[10] : [How to Evaluate ASR Output for Named Entity Recognition ?](https://www.isca-speech.org/archive_v0/interspeech_2015/papers/i15_1289.pdf) (2015)
[11] : [Why word error rate is not a good metric for speech recognizer training for the speech translation task?](https://ieeexplore.ieee.org/abstract/document/5947637) (2011)
[12] : [Evaluating ASR Output for Information Retrieval](https://d1wqtxts1xzle7.cloudfront.net/44281782/Evaluating_ASR_Output_for_Information_Re20160331-31804-1u2wdv8.pdf?1459484689=&response-content-disposition=inline%3B+filename%3DEvaluating_ASR_Output_for_Information_Re.pdf&Expires=1641991659&Signature=DMkXBKRcISYtsJw2M6l9P4Lth-0ZEF6plQyHD08TWaIhRZSaZdFCmtTagKLx7YMLGX~ZxvQtgiQe4EHJcZ-aGL5DiUh3Vfztn7feWDMZF~bEgFMluedYI6Jq39t0BBd2mVJjuUVCVtx1-S--pH89PQ9aFcfpbSH4W88uytgZHwXyZyeR9tIVzM45lblIVeFtvVNwREc6jmm1ijW4ir0lGbGlfI2DoLXwyYFM6pltQHngtoVtAfBrBF3XOMB2AwXA0hQkSDlO0v~iwletUK1o3xBdmb6MrK47A7nt8TlO9xFB33RA8hrN-KnafvJGdhI-Or8Ic2HN4cWlXvr~2uetNg__&Key-Pair-Id=APKAJLOHF5GGSLRBV4ZA#page=19) (2007)
[13] : [Semantic Distance: A New Metric for ASR Performance Analysis Towards Spoken Language Understanding](https://arxiv.org/pdf/2104.02138.pdf) (2021)
[14] : [Which ASR should I choose for my dialogue system?](https://aclanthology.org/W13-4064.pdf) (2013)
[15] : [Rethinking evaluation in ASR : Are out models robust enough ?](https://arxiv.org/pdf/2010.11745.pdf) (2021)
