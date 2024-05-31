#ifndef __imdb_utils__
#define __imdb_utils__

#include <vector>
#include <string>
#include <iostream>
using namespace std;

/**
 * Convenience struct: film
 * ------------------------
 * Bundles the name of a film and the year it was made
 * into a single struct.  It is a true struct in that the 
 * client is free to access both fields and change them at will
 * without issue.  operator== and operator< are implemented
 * so that films can be stored in STL containers requiring 
 * such methods.
 */

struct film {
  
  string title;
  int year;
  
  /** 
   * Methods: operator==
   *          operator<
   * -------------------
   * Compares the two films for equality, where films are considered to be equal
   * if and only if they share the same name and appeared in the same year.  
   * film is considered to be less than another film if its title is 
   * lexicographically less than the second title, or if their titles are the same 
   * but the first's year is precedes the second's.
   *
   * @param rhs the film to which the receiving film is being compared.
   * @return boolean value which is true if and only if the required constraints
   *         between receiving object and argument are met.
   */

  bool operator==(const film& rhs) const { 
    return this->title == rhs.title && (this->year == rhs.year); 
  }
  
  bool operator<(const film& rhs) const { 
    return this->title < rhs.title || 
           this->title == rhs.title && this->year < rhs.year; 
  }
};

/**
 * Quick, UNIX-dependent function to determine whether or not the
 * the resident OS is Linux or Solaris.  For our purposes, this
 * tells us whether the machine is big-endian or little-endian, and
 * the endiannees tells us which set of raw binary data files we should
 * be using.
 *
 * @return one of two data paths.
 */

inline const char *determinePathToData(const char *userSelectedPath = NULL)
{
  if (userSelectedPath != NULL) return userSelectedPath;
  
  const char *ostype = getenv("OSTYPE");
  if (strcasecmp(ostype, "linux") == 0)
    return "/usr/class/cs107/assignments/assn-2-six-degrees-data/little-endian/";
  if (strcasecmp(ostype, "solaris") == 0)
    return "/usr/class/cs107/assignments/assn-2-six-degrees-data/big-endian/";
  
  cerr << "Unsupported OS... bailing" << endl;
  exit(1);
  return NULL;
}

#endif
