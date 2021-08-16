---
title: Code Mixing Metrics
date: 2021-08-09
tags: [code-mixing, tts, asr]
categories: [Machine Learning]
image: assets/images/demo1.jpg
layout: post
authors: [swarajdalmia]
latex: True
---

# Terminologies

Because how can one study a phenomena without having a requisite vocabulary.

- **Matrix Language :** The Matrix Language-Frame (MLF) model is one of the dominant models to analyse code-switching. In this framework there is a Matrix Language and an Embedded Language. The embedding language is inserted into the mono-syntactic frame of the Matrix language.
- **Inter-sentential switching :**  Occurs *outside* the sentence or the clause level
- **Intra-sentential switching** : Occurs *within* a sentence or a clause
- **Intra-word switching** : Occurs *within* a word itself, sometimes at phoneme boundaries example : “I’m chalaaoing a car” → “i am driving a car”
- **Language Span:** The number of monolingual words between 2 consecutive switch points in the corpus. The language span distribution is the aggregate of all such language spans into a discrete pdf.


The performance of models on code-mixed corpora, would depend on the level of code-mixing. A minuscule level of code-mixing could be treated as noise/OOV and ignored. However, as the level of code-mixing increases, the performance of the model will vary. Therefore it is important to quantify the extent of code-mixing in a corpora; “how much” and
“how often”. In the first [paper](https://arxiv.org/pdf/2004.12376.pdf) covered in the code-mixing seminar, there were several metrics presented, however they were not discussed in detail. We discuss them below.

# Measuring the amount of Code-Mixing

## Word-frequency based metrics

[**Code-Mixing Index (CMI)**](https://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.727.9087&rep=rep1&type=pdf) : An utterance level metric that measures the fraction of tokens(words) that are not from the matrix language.

$$CMI = 100*(1 - \frac{max(w_i)}{n-u}) \text{ if } n>u$$  

where,  
n = total number of words, irrespective of language  
u = language independent words  
$$w_i$$ = number of words in language i  
$$max(w_i)$$ measures the number of words in the matrix language   

 If $$n=u$$ i.e. if the utterance contains only language independent words then CMI = 0.

One way calculate CMI for the entire corpus is to just calculate the above at a corpus level rather than an utterance level. However, this method doesn’t take into account the switching frequency. Another way is to combine the utterance level CMI as discussed [here](https://www.aclweb.org/anthology/L16-1292.pdf).

[**Multilingual Index (M-index)**](https://www.isca-speech.org/archive/Interspeech_2017/pdfs/1429.PDF) : Quantifies the ratio of languages in the corpora based on the Gini coefficient to measure the inequality distribution of languages in the corpus.

$$M-index = \frac{1-\sum p_j^2}{(k-1).\sum p_j^2}$$

where,  
k = number of languages  
$$p_j$$ = number of words in language j divided by total number of words  

The M-index = 0 when the corpus is monolingual and = 1 when there is equal distribution of token across all the languages i.e. $$p_j$$ for all $$j = 1/k$$.


[**Language Entropy (LE)**](https://www.isca-speech.org/archive/Interspeech_2017/pdfs/1429.PDF) :  An information theoretic alternative to the M-index. Measures the number of bits required to describe the distribution of language tags.

$$LE = -\sum_{1...k} p_i*log_2(p_i)$$

where,  
k = number of languages  
$$p_i$$ = number of words in language j divided by total number of words  

This metric is 0 for a monolingual corpus and is bounded by $$log_2(k)$$ for equally distributed k languages. Both LE and M-index can be derived from one another.

However, just specifying the frequency of words belonging to another language doesn’t provide enough information. A corpus with a higher frequency of language switches per utterance is more complex, therefore we need some measures on the frequency and distribution of code-switching points.

## Measuring code-switching

[**Probability of Switching (I-index)**](https://www.isca-speech.org/archive/Interspeech_2017/pdfs/1429.PDF) : The average number of switch points in the corpus.

$$f_n = P/(N-1)$$

where,  
$$P$$ = number of code-switching points  
$$N-1$$ = possible switching points in a corpus that contains n tokens  

A token is considered a switch point, if the preceding token is from another language.

## Time-course Metrics

Since, a corpus is a sequential document, it is informative to have a time-series metrics that quantifies the temporal distribution of code-switching across the corpora.

[**Burstiness**](https://www.isca-speech.org/archive/Interspeech_2017/pdfs/1429.PDF) : Measures whether code switching occurs in bursts or is periodic is nature. It compares the code-switching behaviour in the corpus to a poisson behaviour where code-switching occurs at random.   

Let, $$\mu_t$$ = mean language span and $$\sigma_t$$ = s.t. of language span, then

$$Burstiness = \frac{\sigma_t-\mu_t}{\sigma_t+\mu_t}$$

Burstiness is bounded by $$[-1,1]$$. For, corpus that have a periodicity in code-switching points, this value is closer to -1 and for corpuses that have less predictable periodicity have a value closer to 1.  

[**Span Entropy (SE)**](https://www.isca-speech.org/archive/Interspeech_2017/pdfs/1429.PDF) : An information theoretic measure of the language span distribution i.e. the number of bits needed to describe the probability distribution.

$$SE = -\sum_{1...M} p_l*log_2(p_l)$$

where,  
$$p_l$$ is the sample probability of a language span of length l  
M is the maximum language span  


[**Memory**](https://www.isca-speech.org/archive/Interspeech_2017/pdfs/1429.PDF) : The above two metrics don’t make any claims about the time ordering of the language spans i.e. say if a long span occurs below or after the current span, then there would be no difference in the above metric values. Corpus’ with the same burstiness can have very different properties. This metric measures the extent to which the $$i^{th}$$ span length is influenced by span lengths occurring before it. This metric is bounded by $$[-1,1]$$. When it is closer to -1, then the length of consecutive spans in negative correlated i.e. long spans followed by short ones.


# Evaluating Code-Mixed ASR and TTS


## ASR

Conventional word error rate is not sufficient for measuring the performance of code-mixed models due to cross-transcription, misspellings and borrowing of words.

One of the issues for transcription of code-mixed speech is transliteration. For example, say the actual transcripts contain first two words of a sentence in Devanagari and the last 2 in Roman but the transcripts from ASR contain only Roman script. Then unless we have transliteration, we can’t get accurate WER scores. This issue is further compounded by non-uniform transliteration standards, across both the training data and the eval data especially since languages often borrow words from other languages.

However, there are no standard metrics that exist as of now. Below two metrics that measure different aspects are discussed.


[**CM-WER**](https://www.cse.iitb.ac.in/~pjyothi/files/IS19.pdf) : If there are M words on both sides of switch points across all reference transcriptions and N edits in the ASR hypotheses corresponding to words surrounding the switch points in the references, then $$\text{CM-WER} = \frac{N}{M}$$ . This metric provides an estimate of how accurately the system predicts words at switch points.


[**poWER**](https://www.researchgate.net/profile/Brij-Srivastava-2/publication/327388676_Homophone_Identification_and_Merging_for_Code-switched_Speech_Recognition/links/5be04751299bf1124fbbf419/Homophone-Identification-and-Merging-for-Code-switched-Speech-Recognition.pdf) : Prononciation Optimised WER. It is defined as the Levenshtein distance between the pronunciation optimized hypothesis (H) and reference (R) sentence, normalised by the number of words in the reference sentence.

$$\text{poWER} = \text{LevDist}(f(H), f(R))/N$$

Here, $$f$$ = grapheme-to-phoneme (g2p) conversion of each word in the sentence

So, for example, the following below sentences would have a poWER of zero.

HYP : रूम service आपको कै सी लग  
REF : room service आपको कै सी लग

## TTS
**Degradation MOS :** Annotators listen to a sample audio which is considered to have no degradation. The next audio is rated in comparison to that, in terms of degradation, out of 5. A score of 5 means no degradation, a score of 1 means the highest degradation. While testing a code-mixed TTS, it one can use degradation score of monolingual sentences generated from Multi-lingual TTS as compared to Mono-lingual TTS.

## Notes
- The above measures can be used to specify different patterns of code switching which have been termed as “[code-switching attitudes](http://grlmc.wdfiles.com/local--files/slsp-2013/Day2Session2_03Heike_CS-attitude_dependent_LM.pdf)”. These can be thought of as aspects of personality and are correlated with regional identities and other trait properties.

If you have any questions please reach out to *swaraj@vernacular.ai*.

# References
- [Comparing the Level of Code-Switching in Corpora](https://www.aclweb.org/anthology/L16-1292.pdf)
- [On measuring the complexity of code-mixing](https://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.727.9087&rep=rep1&type=pdf)
[](http://amitavadas.com/Social_India/SOCIAL_INDIA_2014_PROCEEDING.pdf#page=6)- [Metrics for modeling code-switching across corpora](https://www.isca-speech.org/archive/Interspeech_2017/pdfs/1429.PDF)
- [Simple tools for exploring variation in code-switching for linguists](https://www.aclweb.org/anthology/W16-58.pdf#page=24)
- [Burstiness and memory in complex systems](https://arxiv.org/pdf/physics/0610233.pdf)
