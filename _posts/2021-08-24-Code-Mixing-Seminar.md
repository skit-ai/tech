---
title: Seminar - Code Mixing in NLP and Speech
date: 2021-08-24
tags: [asr, tts, code-mixing]
categories: [Machine Learning]
image: assets/images/tile-work.png
layout: post
authors: [kritianandan, swarajdalmia, greed2411, Shangeth, Shahid, Shashank]
latex: True
---

Below are some pointers and insights from the papers that we covered in the recently concluded [seminar on Code-mixing in NLP and Speech](https://vernacular-ai.github.io/seminars/topics/). During the seminar we covered 6 papers, two each from NLP, Speech Synthesis and Speech Recognition.

# Session-1 (NLP)
**Paper**: [GLUECoS : An Evaluation Benchmark for Code-Switched NLP](https://arxiv.org/pdf/2004.12376.pdf)<br>
**Presenter**: Shashank Shailabh

The main idea of GLUECoS is to introduce a benchmark evaluation task set for code-switched NLP. It is inspired from GLUE (Generalized Language Evaluation Benchmark) and covers tasks such as Language Identification (LID),  Part-Of-Speech (POS) Tagging, Named Entity Recognition (NER), Question & Answering (QA), Natural Language Inference (NLI) and sentiment analysis (SENT).  and also introduces benchmark code-mixed datasets. The language pairs that this benchmark covers in English-Spanish and English-Hindi code-mixed datasets. The paper also introduces several Metrics, most of which are covered in the previous blog on Metrics for Code-switching.

To arrive at a baseline performance, several cross-lingual word embeddings models such as MUSE (supervised and unsupervised embeddings), BiCVM, Biskip and GCM embeddings are used. For supervised cross-lingual embeddings one requires a parallel mono-lingual corpus of the two languages such that each sentence in one language maps as close as possible to the parallel sentence in the other language. In the unsupervised setting an adversarial loss is used to train cross-lingual embeddings. The other model that is used for the baseline is multilingual models (mBERT). This model is simply trained on monolingual data from each language, and has no explicit loss to map the embedding of the same words from both languages to the same point. Another fine-tuned version of mBert is used which is fine-tuned on synthetically generated code-switched data. Interestingly the mBert model performs better as compared the cross-lingual embeddings and fine-tuning on synthetic data further improves performance.


# Session-2 (Speech Synthesis)
**Paper**: [Building Multilingual End-to-End Speech Synthesisers for Indian Languages](https://arxiv.org/pdf/2008.00768v1.pdf)<br>
**Presenter**: Swaraj

The goal of the paper is to build a Multilingual TTS for Indic languages in a low data resource setting. The paper discusses ways of assimilating inputs from different indian scripts both at the level of characters and phonemes, into a common input set. This leverages the similarities in phonemes and the structure of Indian languages which fall in the Abjad class of languages where vowels are diacritics.  

For phonemes, it looks at 2 approaches : a transliteration approach using the unified parser and the common label set; and another approach that considers a 1:1 phoneme map between the different languages. At character level they present the MLCM character set that is 68 characters in total and combines 8 indic scripts. Since vowels are a major component in indic languages, they consider approaches where the vowel and vowel modifier are mapped to the same and different input token. For modelling they use tacotron-2 and compare the impact of various input tokens on performance for monolingual and multilingual settings. The primary take away from the discussion were the different ways of combining and varying the input representations for training an Indic language TTS.


# Session - 3 (NLP)
**Paper**: [BERTologiCoMix, How does Code-Mixing interact with Multilingual BERT?](https://aclanthology.org/2021.adaptnlp-1.12.pdf)<br>
**Presenter**: Jaivarsan B

This paper addresses the impact (on code-mixed tasks) of fine-tuning with different types of code-mixed data and outlines the changes to mBERT’s attention heads during such fine-tuning. Code-mixing can be treated as a domain adaptation problem, but in this particular context it is to adapt at the grammatical level, not purely at the vocabulary level or style level. For sake of empirical study they evaluate two different language pairs, English-Spanish (enes), English-Hindi (enhi) with the extra three different varieties on them. Those three varieties are namely: randomly-ordered CM (l-CM), grammatically appropriate CM (g-cm) and real-world CM (r-CM), so in total we have 2 lang pairs $$\times$$ 3 varieties = 6 possible fine-tuning datasets on mBERT against the plain mBERT.

They evaluate these 6 combinations of CM datasets on GLUECoS benchmark. They empirically find out that naturally occurring code-mixed data (r-CM) brings in the best performance improvement after fine-tuning, against synthetic fine-tunings (l-CM, g-CM) and even plain mBERT. Other task specific observations include: fine-tuning with r-CM data helps with SENT, NER, LID and QA CM tasks. General trend observed was easier tasks like LID, POS are solved in earlier layers and as complexity of tasks increases, the effective layer moves deeper. This paper’s other significant contribution is to visualize the differences to these mBERT attention heads post-CM-fine-tuning. They use three methods (including one of their own contribution), which try to answer questions related to: Has anything changed within the models due to pre-training with CM datasets? Attention patterns of which heads have changed? How do attention heads respond to code-mixed probes?. There are changes to these models, which show these attention heads are receptive to CM specific data at different layers of mBERT for different tasks and different language pairs.

The most important finding from these probing experiments is that there are discernible changes introduced in the models due to exposure to CM data, of which a particularly interesting observation is that this exposure increases the overall responsivity of the attention heads to CM.


# Session - 4 (Speech Recognition)   
**Paper**: [Exploiting Monolingual Speech Corpora for Code-mixed Speech Recognition](https://www.researchgate.net/profile/Karan-Taneja/publication/335829565_Exploiting_Monolingual_Speech_Corpora_for_Code-Mixed_Speech_Recognition/links/602571e3299bf1cc26bcbce9/Exploiting-Monolingual-Speech-Corpora-for-Code-Mixed-Speech-Recognition.pdf)<br>
**Presenter**: Kriti Anandan

This paper aims to mitigate the problem of scarcity in code-mixed datasets for training ASR models robust to code-mixed data. It introduces two algorithms to synthetically generate code mixed data by using annotated monolingual data sets that are available in large quantities and a small amount of annotated real code-mixed data. Both these algorithms make use of probability distributions derived from real code-mixed data to imitate their characteristics. The code-mixed sentences are framed from sentence fragments extracted from the monolingual corpus. In the paper, first algorithm is a naïve approach that uses the code-mixed language span distributions to weave fragments of two different languages in an alternate fashion where fragment lengths are picked by sampling the distribution. The second algorithm uses two distributions that try to model phone transitions across fragments and within fragments.

The authors also demonstrate the usefulness of these synthetically generated datasets by adding them to the existing monolingual dataset for training the acoustic model of an ASR. Results from the best acoustic model show a ~ 6.85 point drop in WER score. They also conduct some language modelling experiments by using code-mixed transcripts to train the language model of the ASR. The best system uses the best acoustic model trained from the previous experiment and the language model trained on the synthetic text generated by all the algorithms presented, as well as the real code-mixed text. The results via this method show a ~ 8.17 point drop in the WER score.


# Session - 5 (Speech Recognition)  
**Paper**: [Learning to recognize code switched speech without forgetting monolingual speech recognition](https://arxiv.org/pdf/2006.00782.pdf)<br>
**Presenter**: Shahid Nagra

The goal of the paper is to fine tune ASR models on code switched speech without affecting the performance on the same models on monolingual speech. They propose the use of a learning without forgetting algorithm. This approach can also be used when one doesn’t have access to the monolingual data that the model was trained on, which is often the case for open-source ASR models.

They conducted 5 experiments where training and fine-tuning is varied across the 3 datasets, monolingual and code-mixed and pooled. The best model performance is got when fine-turning a model on pooled data (code-mixed + monolingual) where only 25% of code-mixed data is used. An extra KL Diverge loss between the fine-tuned and the pre-trained model is added to prevent the increase in WER on the monolingual data. A metric poWER is also introduced which measures the Levenstein distance between the phonemic representation of utterances which takes care of measuring WER in the code-mixed setting.


# Session - 6 (Speech Synthesis)  
**Paper**: [Code-Switched Speech Synthesis Using Bilingual Phonetic Posteriorgram with Only Monolingual Corpora](https://www1.se.cuhk.edu.hk/~hccl/publications/pub/Icassp20_cstts_camera_ready.pdf)<br>
**Presenter**: Shangeth Rajaa

This paper aims to synthesize fluent code-switched speech using only monolingual speech corpora and explores the usage of Bilingual Phonetic Posteriorgram (PPG) as the speech representation. PPGs are the posterior probabilities of each phonetic class for a specific frame of one utterance, stacking up the PPG for two languages forms the bilingual PPG. As obtaining a bilingual/code-switched speech corpus for TTS training can be expensive, this paper solves the problem, by training a tacotron2 based code-switched TTS system with only the monolingual corpus of both the languages (English and Chinese) where each language is spoken by a different speaker. The trained model is then evaluated by generating speech for a code-switched text corpus with Mean Opinion Score (MOS) score.

The paper introduces the use of Bilingual PPG as a representation of speech as PPGs are speaker-independent and can capture the context of the speech better, PPG features are computed with a pretrained ASR model for each language. They replaced the traditional acoustic model which predicts the acoustic features(Mel Spectrogram) directly from text, to predict the PPG from the text, followed by predicting the Mel Spectrogram from the predicted PPG, speaker embedding and language embedding. The proposed method also includes a residual encoder to encode the speech into a latent space in a Variational AudioEncoder (VAE) setting which helps to model the prosodic features of the audio. The proposed method was compared with a tacotron2 based text to acoustic feature (Mel spectrogram) model baseline. As the proposed method uses a PPG feature, the model was able to disentangle the context information of the speech signal across different speakers and synthesize better code-mixed speech by combining the PPG feature, speaker embedding, language embedding, and prosody features.

From the experimental results, we can observe that the proposed method can synthesize high intelligible code-switched speech with a cross-lingual speaker (eg: Chinese speaker for English/code-switched text) with only training on a monolingual corpus. But the proposed method failed to beat the baseline in speech fidelity MOS score. The authors stated that the Bilingual PPG extracted was not accurate enough and needs to be further studied in future work.

Do check out the blog on [Code-Mixing metrics](https://tech.skit.ai/Code-Mixing-Metrics/) if you haven’t already. Please write to us in case you want to join any of our future seminars.
