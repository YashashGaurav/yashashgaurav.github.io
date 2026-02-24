---
title: "Few-shot Learning notes (Prof Shusen Wang)"
date: 2022-11-21
draft: true
tags: ["Few-shot Learning", "Meta Learning", "Siamese Networks", "Deep Learning"]
categories: ["AI/ML/DL"]
author: "Yashash Gaurav"
showToc: true
description: "Notes from Prof Shusen Wang's lecture series on few-shot learning — covering Siamese Networks, pretraining with fine-tuning, and entropy regularization."
cover:
  image: "/images/posts/few-shot-learning-notes-shusen-wang_cover.png"
  alt: "Few-shot learning illustration"
  hidden: false
---

## Few-Shot Learning (1/3): Basic Concepts

Video: https://www.youtube.com/watch?v=hE7eGew4eeg

- Train on whether two samples have the same class or different class (these are called support set)
- At eval time, given samples with their classes specified (eval-class-set),
- Now given a new-sample-image, you pass it through the model and see if eval-class-set samples match to the new-sample-image and if it does, we say the new-sample-image is closest to the class of the eval-class-set image it closely resembles.
- Learning to learn by itself is called meta learning.
  - For a trained model to identify as below is meta learning.

---

## Few-Shot Learning (2/3): Siamese Networks

Video: https://www.youtube.com/watch?v=hE7eGew4eeg

---

## Few-Shot Learning (3/3): Pretraining + Fine-tuning

Video: https://www.youtube.com/watch?v=U6uFOIURcD0

Cosine similarity = dot product of unit vectors.

**Softmax**

Softmax when applied to output of multi-class classifiers, the output is a distribution of positive numbers that sum up to one where they add up to one. In this case smaller numbers are suppressed and larger numbers are scaled up.

Softmax is called softmax because it is softer than the max() function that only gives us the class that has the largest value and suppresses the smaller value than the largest value.

Using the above for few shot predictions, we find the average embedding for every support class given their n-shots.

Above we have 3 classes and their normalized average embeddings for each class. If we create a matrix M, as shown below:

We can take a dot product of the matrix made from normalized average embeddings to the normalized query embedding, and the output can be put through softmax to get a likeness distribution on the classes predicted.

---

### Fine tuning in Few shot learning

We can instantiate a Matrix W with M (stack of normalized average embeddings of support classes) as above. And then multiply each instance in the support set to matrix W, take a softmax on the output generated, take a cross entropy on the output generated vs true labels expected to formulate loss and train matrix W.

Because the dataset is small the matrix W can over fit, hence to generalize, we regularize (remember Occam's razor)

We can potentially even pass the loss generated through the CNN model as well.

---

### Tips and Tricks

1. Initializing the final linear layer with a bias for classification with normalized average embeddings of support classes is a good idea.

2. The video suggests Entropy Regularization as suggested in https://arxiv.org/pdf/1909.02729.pdf:
   - I think the video does a brilliant job of explaining Entropy regularization:

Essentially, during fine-tuning, we want to make sure distribution is created after every pass of support sample peaks for just one class. To calculate this, we take the entropy of the distribution and add that to the loss. If the entropy is high, all values in the output is similar, if there are high peaks in the softmax output, the entropy is low (as we want it to be). [super cool]

3. Cosine Similarity + softmax Classifier:

Making sure the except just matrix multiplication that is the multiplication of rows of matrix W to query embedding, if we multiply their normalized vectors → we get cosine similarity. (papers on this being better)
