/**
 * File: production.h
 * ------------------
 * Defines the abstraction for the Production class, 
 * which encapsulates the functionality needed to store
 * a contiguous list of strings.
 */
 
#ifndef __production__
#define __production__

#include <vector>
#include <fstream>
#include <iostream>
#include <string>
using namespace std;

class Production {
  
 public:
  
  /**
   * Provides STL-like iterator access to the sequence of items making up
   * a Production instance.
   */
  
  typedef vector<string>::iterator iterator;
  typedef vector<string>::const_iterator const_iterator;
  
 public:
  
  /**
   * Default Constructor: Production
   * -------------------------------
   * Presented so that variables of type
   * Production may be declared without meaningful
   * initialization.  It is the responsibility
   * of the client to assign such a Production to
   * be a clone of a legitimate one if the Production
   * is to be of any value.
   *
   * The primary reason this is here is that the 
   * vector class requires its element type to
   * have a default constructor.
   */
  
  Production() {}
  
  /**
   * ifstream Constructor: Production
   * --------------------------------
   * Initializes the Production based on the contents
   * of the specified ifstream.  The ifstream is presumably
   * positions at the start of a line that houses a production.
   * Leading whitespace is discarded, the series of terminals and
   * non-terminals are read in until a semicolon is consumed, and
   * the the rest of the data is discarded.
   */
  
  Production(ifstream& infile);
  
  /**
   * vector<string>-backed Constructor: Production
   * ---------------------------------------------
   * Initializes a new Production to just encapsulate
   * a copy of the provided vector.
   */
  
  Production(const vector<string>& words) : phrases(words) {}
  
  /**
   * Iterators: begin, end
   * ---------------------
   * Returns an iterator (fancy word for the generalization
   * of a pointer) to the first element or the past-the-end 
   * element.  These iterators really are pointers to strings,
   * so they respond properly to the notion of increment and
   * dereference.
   * 
   * These functions are provided so that the Production
   * class, which is really just an ordered collection of
   * words, can be traversed via iterators using the following
   * control idiom.
   *
   *    for (Production::iterator curr = prod.begin(); curr != prod.end(); ++curr) {
   *        // manipulate curr (psuedo-pointer to C++ strings) or *curr (direct string objects).
   */
  
  iterator begin() { return phrases.begin(); }
  const_iterator begin() const { return phrases.begin(); }
  iterator end() { return phrases.end(); }
  const_iterator end() const { return phrases.end(); }
  
 private:
  vector<string> phrases;
};

#endif
