#!/usr/bin/python
# -*- coding: utf-8 -*-

# SKFOLD - Self-organizing Kohonen principal-mainFOLD-approximation map
# Copyright (c) 2016 Emanuele Ballarin
# Software released under the terms of the MIT License

import random
import math
import matplotlib.pyplot as plt

# The purpose of the script is to build and drive a Self-Organizing Map (SOM)
# which generalizes the Principal Component Analysis (PCA) approach in the
# elaboration of data points, arbitrarily distributed in 2 dimensions.
# The net is unidimensional, and at the end of the self-training process it
# displaces itself so as it lies on the principal curve that best explains
# the dataset total variance.
# The net has a fixed number of neurons and evolves following Teuvo Kohonen's
# algorithm, in an exponentially-decaying time- and learning-rate- adaptive
# fashion.

# OUTPUT OF THE PROGRAM
neurmap = []  # List of couple-listed neurons' coordinates (in the xy plane)


# Functions
def eudist(a, b):
    """ The function calculates the Euclidean Distance in two dimensions """
    return math.sqrt((a[0] - b[0])**2 + (a[1] - b[1])**2)

# Variables
Nneur = 24  # Number of Neurons (for the choice: cfr.: Michele Filannino)
epsilon = 0.2  # Normalized learning rate (cfr.: Marco Budinich)
sigma = 18  # Gaussian decay factor

# Data acquisition
dataset = []  # Initialized empty

with open('datagen.txt', 'r') as source:
    for line in source:
        buffer = list(map(float, line.split()))  # Maps each line into couple...
        dataset.append(buffer)  # ...and appends the list (couple) to dataset

Npoints = len(dataset)  # Computes the dataset lenght











# PLAYGROUND

