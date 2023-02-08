#!/bin/sh
#######################################################################
# THIS IS THE TEST SCRIPT FOR THE INDRI QUERY LANGUAGE                #
#######################################################################
# First erase any existing files 
# rm -r index
# mkdir index
# cd index
# # mkdir non_stop
# mkdir stop
# # mkdir index_without_stemming
# # mkdir index_stemming
# cd ..

#######################################################################
# The following command builds a position index of the CACM database  #
#  directly from a simple SGML format source                          #
# Note that the version of database.sgml used has been modified to    #
# include <TEXT> tags around the body of each document.               #
# Uses the stopword list provided in smallstop_param.                 #
#######################################################################

# echo "Build Index ..."
# # IndriBuildIndex index_param/non_stop.xml
# IndriBuildIndex index_param/stop.xml
# # IndriBuildIndex index_param/stemming.xml
# # IndriBuildIndex index_param/no_stemming.xml

#######################################################################
# The following shows how to run simple retrieval                     #
# experiments with indri query language queries.                      #
#######################################################################

echo "Run Query ..."
# simple query retrieval example
#okapi
# IndriRunQuery query_param/okapi/ret_non_stop.param query.txt > res/okapi/res_non_stop.txt
IndriRunQuery query_param/okapi/ret_stop.param query_title.txt > res/okapi/res_stop.txt
# IndriRunQuery query_param/okapi/ret_stem.param query.txt > res/okapi/res_stem.txt
# IndriRunQuery query_param/okapi/ret_without_stem.param query.txt > res/okapi/res_without_stem.txt

#echo "----------------------------------------------------------------"
# echo "non non OKAPI"
# perl trec_eval qrels.401-450.txt res/okapi/res_non_stop.txt
# echo "STOP non OKAPI"
perl trec_eval qrels.401-450.txt res/okapi/res_stop.txt
# echo "NON STEM OKAPI"
# perl trec_eval qrels.401-450.txt res/okapi/res_without_stem.txt
# echo "STOP STEM OKAPI"
# perl trec_eval qrels.401-450.txt res/okapi/res_stem.txt



#lm
# IndriRunQuery query_param/lm/ret_non_stop.param query.txt > res/lm/res_non_stop.txt
IndriRunQuery query_param/lm/ret_stop.param query_title.txt > res/lm/res_stop.txt
# IndriRunQuery query_param/lm/ret_stem.param query.txt > res/lm/res_stem.txt
# IndriRunQuery query_param/lm/ret_without_stem.param query.txt > res/lm/res_without_stem.txt

echo "----------------------------------------------------------------"
# echo "non non LM"
# perl trec_eval qrels.401-450.txt res/lm/res_non_stop.txt
# echo "STOP non LM"
perl trec_eval qrels.401-450.txt res/lm/res_stop.txt
# echo "NON STEM LM"
# perl trec_eval qrels.401-450.txt res/lm/res_without_stem.txt
# echo "STOP STEM LM"
# perl trec_eval qrels.401-450.txt res/lm/res_stem.txt


#jm

IndriRunQuery query_param/jm/jm_stop.param query_title.txt > res/jm/res_stop.txt
echo "----------------------------------------------------------------"
perl trec_eval qrels.401-450.txt res/jm/res_stop.txt