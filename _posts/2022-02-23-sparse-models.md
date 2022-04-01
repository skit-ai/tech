---
title: Speeding up Inference with the Lottery Ticket Hypothesis
date: 2022-02-23
tags: []
categories: [Machine Learning]
layout: post
authors: [ojus1]
latex: True
---

The most fancy tool in the Modern Machine Learning toolbox are Neural Networks (NNs), 
especially _Deep_ ones. NNs usually have much more number of parameters than the 
number of datapoints, and hence are _overparameterized_ models. Are all of the parameters 
needed and perform a useful function in the model? 

The Lottery Ticket Hypothesis (LTH) [1] states that for a reasonably-sized NN, there
exists at least one sub-network (i.e., an NN with some of the parameters/weights
removed) when trained from scratch that is at least as performant as the full network.

The Lottery Ticket Hypothesis is named as such because of the reasoning that
there can exist millions of sub-networks in even a relatively small NN; finding
these well-performing sub-networks (or _winning tickets_) amongst all the possible
networks (lottery tickets) is akin to a winning a lottery.


<figure>
<center>
  <img alt="Pruning" src="/assets/images/posts/sparse-models/prune.png"/>
  <figcaption>Fig 1: Illustration of Weight Pruning in a Neural Network. Image adapted from [4].</figcaption>
</center>
</figure>

## Sparse Models? Why?

Having sparse models have direct consequences for deployment purposes:

1. If most of the weights are zeros, we can store the weights in CSR/CSC format, and
only store the non-zero indices; leading to a very small disk footprint.

2. Matrix Multiplications and other operations for zero-ed elements can be ignored,
leading to a sharp decline in the number of Floating Point Operations during inference.

3. Performance in terms of robustness to noise and accuracy can acutally *increase* when
performing sparsification, as shown by [3] for Automatic Speech Recognition.

## The Search of Winning Tickets

Finding winning tickets reliably is called the _Ticket Search_ problem. This is
usually done by using some sort of weight pruning (zero-ing weights) which are
less important. Each pruning method has its own way of measuring importance.
This pruning is done in an iterative fashion, the procedure of Iterative Magnitude
Pruning (IMP) is as follows:
1. Initialize a network `M` and store its initial weights.
2. Train the network `M` on the dataset.
3. Prune `p` number of weights from `M`.
4. Restore `M` to its initial weight values, except for the pruned weights.
5. Repeat steps 2-4 `k` times.

With sufficiently small `p` and large `k`, we can reliably find winning tickets.
LTH and successive works have shown that IMP and variants (such as Layer-adaptive
Magnitude Pruning, LAMP [2]) can remove upto 90% of weights without degrading
performance for Vision and NLP tasks; however the same can be applied to almost any task.

## Can we find Winning Tickets from Pre-trained models?

One of the statements of LTH is that the network needs to be rewinded to its initial state. However, it is a common use-case that we take a large pre-trained model such as Wav2Vec2 and then finetune on a down-stream task which usually is a much smaller dataset.

Can we treat these pre-trained weights as the "initial state" in LTH and be able to find sparse models? Authors from [3] show that this is true. They show that they were able to prune away upto 95% of weights while achieving comparable WER on multiple architectures, ranging from CNN-LSTM, RNN-Transducer to Conformer and two public datasets (Common Voice and LibriSpeech).

<figure>
<center>
  <img alt="Ticket Search for Pretrained Models" src="/assets/images/posts/sparse-models/pretrained.jpeg"/>
  <figcaption>Fig 2: Iterative Pruning for Pretrained Models. x-axis: Percentage of Weights remaining after each pruning stage. y-axis: Word Error Rate (WER) % </figcaption>
</center>
</figure>

In Fig 2, $$\theta_0$$ denotes random initialization, $$\theta_{CV}$$ denotes transfering from weights trained on CommonVoice, and $$\theta_{Libri}$$ denotes transfering from weights trained on LibriSpeech. WER is reported on TED-LIUM dataset. 

We can observe that, as expected, models initialized with pretrained weights have a lower WER, however, the drop in WER due to Ticket Search is lower but comparable to non-pretrained initialization.


## Conclusion
Pruning, traditionally only thought of as a way to speedup inference. However, The Lottery Ticket Hypothesis shows that iterative pruning can improve performance and robustness of models, in-addition to speeding up inference!

Iterative Pruning (or Ticket Search) is a tool that should be considered to be used at least as a last-ditch effort for your production models.

## References

[1] Frankle, J. & Carbin, M. (2019). The Lottery Ticket Hypothesis: Finding Sparse, Trainable Neural Networks. ICLR. 2019

[2] Lee, J., Park, S., Mo, S., Ahn, S., & Shin, J. (2021). Layer-adaptive Sparsity for the Magnitude-based Pruning. ICLR. 2021

[3] Ding, S., Chen, T., & Wang, Z. (2022). Audio Lottery: Speech Recognition Made Ultra-Lightweight, Noise-Robust, and Transferable. International Conference on Learning Representations. https://openreview.net/forum?id=9Nk6AJkVYB

[4] Benmeziane, Hadjer & Maghraoui, Kaoutar & Hamza, Ouarnoughi & Niar, Smail & Wistuba, Martin & Wang, Naigang. (2021). A Comprehensive Survey on Hardware-Aware Neural Architecture Search. 
