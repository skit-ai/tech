---
title: Speeding up Inference with the Lottery Ticket Hypothesis
date: 2022-02-23
tags: []
categories: [Machine Learning]
image: assets/images/demo1.jpg
layout: post
authors: [ojus1]
---

<script src='https://cdn.plot.ly/plotly-2.8.3.min.js'></script>

The most fancy tool in the Modern Machine Learning toolbox are Neural Networks (NNs),
especially `Deep` ones. NNs usually have much more number of parameters than the
number of datapoints, and hence are `overparameterized` models. Are all of the parameters
needed and perform a useful function in the model?

The `Lottery Ticket Hypothesis` (LTH) [1] states that for a `reasonably-sized` NN, there
exists at least one sub-network (i.e., an NN with some of the parameters/weights
removed) when trained from scratch that is at least as performant as the full network.

The Lottery Ticket Hypothesis is named as such because of the reasoning that
there can exist millions of sub-networks in even a relatively small NN; finding
these well-performing sub-networks (or `winning tickets`) amongst all the possible
networks (lottery tickets) is akin to a winning a lottery.

## Sparse Models? Why?

Having sparse models have direct consequences for deployment purposes:

1. If most of the weights are zeros, we can store the weights in CSR/CSC format, and
only store the non-zero indices; leading to a very small disk footprint.

2. Matrix Multiplications and other operations for zero-ed elements can be ignored,
leading to a sharp decline in the number of Floating Point Operations during inference.

3. Performance in terms of robustness to noise and accuracy can acutally `increase` when
performing sparsification, as shown by [4] for Automatic Speech Recognition.

## The Search of Winning Tickets

Finding winning tickets reliably is called the `Ticket Search` problem. This is
usually done by using some sort of weight pruning (zero-ing weights) which are
less `important`. Each pruning method has its own way of measuring `importance`.
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

## Dismantling The `Lottery` in the Lottery Ticket Hypothesis

In the heart of the hypothesis lies the assumption that `the network needs to be a large model
(i.e., a dense sampling of tickets)` in order for it to contain at least one subnetwork which is
initialized in such a way that it trains to a high-performing model. A recent work [3] argues that this
assumption is incorrect and the size of the network is not the only reason for the emergence of LTH.

The authors of [3] experiment with Ticket Search on a wide range of CNNs with various number of parameters, depth, and structures. They are listed below:

<div align="center">

<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-baqh{text-align:center;vertical-align:top}
.tg .tg-amwm{font-weight:bold;text-align:center;vertical-align:top}
</style>
<table class="tg">
<thead>
  <tr>
    <th class="tg-amwm">Name</th>
    <th class="tg-amwm"># Params</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td class="tg-baqh">LeNet-5</td>
    <td class="tg-baqh">61K</td>
  </tr>
  <tr>
    <td class="tg-baqh">PNASNet-A</td>
    <td class="tg-baqh">0.13M</td>
  </tr>
  <tr>
    <td class="tg-baqh">PNASNet-B</td>
    <td class="tg-baqh">0.45M</td>
  </tr>
  <tr>
    <td class="tg-baqh">ResNet32</td>
    <td class="tg-baqh">0.46M</td>
  </tr>
  <tr>
    <td class="tg-baqh">MobileNetV1</td>
    <td class="tg-baqh">3.22M</td>
  </tr>
  <tr>
    <td class="tg-baqh">EfficientNet</td>
    <td class="tg-baqh">3.59M</td>
  </tr>
  <tr>
    <td class="tg-baqh">ResNet18</td>
    <td class="tg-baqh">11.17M</td>
  </tr>
</tbody>
</table>

</div>

The authors perform ticket search 50 times for each architecture on the CIFAR-10 dataset and compute
trajectory lengths, percentage of surviving weights, test accuracy etc. after each stage of pruning.

### Ticket Search Difficulty

The success rate of finding winning tickets out of 50 trials is denoted as the `Ticket Search Difficulty` of a particular architecture.
In the figures below, the architectures are ordered in increasing order of the number of parameters.

<div align="center">
{% include 2022-02-07-sparse-models/difficulty.html %}
</div>

For the architectures they tested, they conclude that, in general, it is `easier` to find winning tickets for smaller
architectures; which is a contradictory to the assumption of LTH.

### Quality of Winning Tickets

Since larger architectures have more number of sub-networks, one would except to see the highest accuracy
gain as compared to smaller architectures, as there is a higher chances of better-quality
sub-networks to exist in larger architectures.


<div align="center">
{% include 2022-02-07-sparse-models/quality.html %}
</div>

Again, it is observed that ResNet18, which is the larget architecture has the lowest accuracy gain when
compared to its dense counterpart.


## Conclusion

As a last-mile effort in your Machine Learning project, you should consider Iterative Pruning methods to improve generalizability, latency and memory requirements, even if your architecture is already very small/lightweight!

## References

[1] Frankle, J. & Carbin, M. (2019). The Lottery Ticket Hypothesis: Finding Sparse, Trainable Neural Networks. ICLR. 2019

[2] Lee, J., Park, S., Mo, S., Ahn, S., & Shin, J. (2021). Layer-adaptive Sparsity for the Magnitude-based Pruning. ICLR. 2021

[3] Anonymous. (2022). Not All Lotteries Are Made Equal. Submitted to Blog Track at ICLR 2022. https://openreview.net/forum?id=ugXMIHeasoz

[4] Ding, S., Chen, T., & Wang, Z. (2022). Audio Lottery: Speech Recognition Made Ultra-Lightweight, Noise-Robust, and Transferable. International Conference on Learning Representations. https://openreview.net/forum?id=9Nk6AJkVYB
