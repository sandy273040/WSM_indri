#!/bin/sh
#######################################################################
# THIS IS THE TEST SCRIPT FOR THE INDRI QUERY LANGUAGE                #
#######################################################################
re make the modified functions
cd /mnt/c/indri-5.18
./configure
make
sudo make install

# First erase any existing files 
rm -r index
mkdir index
cd index
mkdir non_stop
mkdir stop
mkdir index_without_stemming
mkdir index_stemming
cd ..

#######################################################################
# The following command builds a position index of the CACM database  #
#  directly from a simple SGML format source                          #
# Note that the version of database.sgml used has been modified to    #
# include <TEXT> tags around the body of each document.               #
# Uses the stopword list provided in smallstop_param.                 #
#######################################################################

echo "Build Index ..."
IndriBuildIndex index_param/non_stop.xml
IndriBuildIndex index_param/stop.xml
IndriBuildIndex index_param/stemming.xml
IndriBuildIndex index_param/no_stemming.xml

#######################################################################
# The following shows how to run simple retrieval                     #
# experiments with indri query language queries.                      #
#######################################################################

echo "Run Query ..."
# simple query retrieval example

#okapi
IndriRunQuery query_param/okapi/ret_non_stop.param query.txt > res/okapi/res_non_stop.txt
IndriRunQuery query_param/okapi/ret_stop.param query.txt > res/okapi/res_stop.txt
IndriRunQuery query_param/okapi/ret_stem.param query.txt > res/okapi/res_stem.txt
IndriRunQuery query_param/tfidf/ret_without_stem.param query.txt > res/tfidf/res_without_stem.txt

echo "-----------okapi---------------------------------------------------------------------------"
perl trec_eval qrels.401-450.txt res/okapi/res_non_stop.txt
echo "STOP non OKAPI"
perl trec_eval qrels.401-450.txt res/okapi/res_stop.txt
perl trec_eval qrels.401-450.txt res/tfidf/res_without_stem.txt
echo "STOP STEM OKAPI"
perl trec_eval qrels.401-450.txt res/okapi/res_stem.txt



#lm
echo "----------------------------------------------------------------"
IndriRunQuery query_param/lm/laplace_non_stop.param query.txt > res/lm/res_non_stop.txt
IndriRunQuery query_param/lm/ret_without_stem.param query.txt > res/lm/res_without_stem.txt

echo "-----------------------------------------------------------------------------------"
perl trec_eval qrels.401-450.txt res/lm/res_non_stop.txt
perl trec_eval qrels.401-450.txt res/lm/res_without_stem.txt




#jm
echo "----------------------------------------------------------------"
IndriRunQuery query_param/jm/jm_non_stop.param query.txt > res/jm/res_non_stop.txt
IndriRunQuery query_param/jm/jm_without_stem.param query.txt > res/jm/res_without_stem.txt

echo "-----------------------------------------------------------------------------------"
perl trec_eval qrels.401-450.txt res/jm/res_non_stop.txt
perl trec_eval qrels.401-450.txt res/jm/res_without_stem.txt



#fb
echo "----------------------------------------------------------------"
IndriRunQuery query_param/fb/fb_laplace_without_stem.xml query.txt > res/fb/fb_res_without_stem.txt

#echo "----------------------------------------------------------------"
perl trec_eval qrels.401-450.txt res/fb/fb_res_without_stem.txt
