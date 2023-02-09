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

## Implement Laplace smoothing in codebase
* Put the modified ```LaplaceTermScoreFunction.hpp``` in ```include/indri```directory.
* In ```src/TermScoreFactory.cpp```
  * add ```#include "indri/LaplaceTermScoreFunction.hpp"``` at the beginning
  * add the following code in line 61:
  ```
  else if( method == "laplace" || method == "add_one" || method == "l" ) {
    double alpha = spec.get( "alpha", 1.0 );
    return new indri::query::LaplaceTermScoreFunction( spec.get("index_path", ""), alpha );
  }
   ```

## User Guide
### Environment
This experiment uses Ubuntu 20.04
### Download Indri-5.18
Link to download: https://sourceforge.net/p/lemur/wiki/Home/<br />

### Download Datasets
a set of 50 TREC queries for the corpus, with the standard TREC format having topic title, description and narrative. Documents from the corpus have been judged with respect to their relevance to these queries by NIST assessors. Queries must be downloaded before proceed in the following operation.
### File tree
indri-5.18<br />
|<br />
-----------run.sh<br />
|<br />
-----------WT2G collection<br />
|<br />
-----------queries<br />
|<br />
-----------index params<br />
|<br />
-----------query params<br />
|<br />
-----------< other files ><br />
<br />

### Run
```
./query_build.sh
```
run this script to build queries from TREC queries.

```
./run.sh
```
The above line in terminal builds a pipeline to make the downloaded indri c++ code, build index, run query, and evaluate the return searching results.
Note that queries must be extracted in advance before running the queries.
  
### Ranking results
See report.pdf for detailed comparison.
