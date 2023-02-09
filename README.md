# WSM_indri
This project aims to customize Laplace smoothing and compare the performance of different ways of searching methods.

## Key contribution of this experiment
1. Tuning the below mentioned ranking functions and implementing laplace smoothing function since the original code didn't provide this function.
2. Also, I wrote a C++ function to modify TREC queries' topic and description to compare the ranking results.
3. Indexing methods are modified as well.
4. Provide shell script to run automatically since queries searching may take time. 

## Introduction of indri
This experiment runs the set of queries against the WT2g collection, returns a ranked list of documents (the top 1000) using various ranking functions in a particular format, and evaluates the ranked lists.<br />
The implemented ranking functions include:<br />
* Vector space model, terms weighted by Okapi TF (see note) times an IDF value, and inner product similarity between vectors
* Language modeling, maximum likelihood estimates with Laplace smoothing only, query likelihood
* Language modeling, Jelinek-Mercer smoothing using the corpus, 0.8 of the weight attached to the background probability, query likelihood

## User Guide
