/*==========================================================================
 * Copyright (c) 2004 University of Massachusetts.  All Rights Reserved.
 *
 * Use of the Lemur Toolkit for Language Modeling and Information Retrieval
 * is subject to the terms of the software license set forth in the LICENSE
 * file included with this software, and also available at
 * http://www.lemurproject.org/license.html
 *
 *==========================================================================
 */


//
// LaplaceTermScoreFunction
//
// 26 January 2004 - tds
//

#ifndef INDRI_LaplaceTermScoreFunctionTERMSCOREFUNCTION_HPP
#define INDRI_LaplaceTermScoreFunctionTERMSCOREFUNCTION_HPP

#include<iostream>
#include <math.h>
#include "indri/QueryEnvironment.hpp"
//#include <QueryEnvironment.hpp>

namespace indri
{
  /*! Query processing, smoothing, and scoring classes. */
  namespace query
  {
    
    class LaplaceTermScoreFunction : public TermScoreFunction {
    private:
      double _alpha;
      indri::api::QueryEnvironment *_env;

    public:
      LaplaceTermScoreFunction( const std::string& localIndex, double alpha = 1.0) {
        //std::string& localIndex in parameter
        _alpha = alpha;
        _env = new indri::api::QueryEnvironment();
        _env -> addIndex(localIndex);
      }

      double scoreOccurrence( double occurrences, int contextSize ) {
        //cout << "total unique words: " << double( _env -> termCountUnique()) << endl;
        //cout << "total unique words: " << double( _env -> termCountUnique()) << "\tcontextSize: " << contextSize<< endl;
        double seen = ( double(occurrences) + _alpha ) / ( double(contextSize) + double( _env -> termCountUnique()) );
        return log(seen);
      }
      double scoreOccurrence( double occurrences, int contextSize, double documentOccurrences, int documentLength ){
        return scoreOccurrence( occurrences, contextSize );
      }
    };
  }
}

#endif // INDRI_LaplaceTERMSCOREFUNCTION_HPP
