/**
 * File: definition.cc
 * -------------------
 * Provides the implementation of
 * the Definition class, which is really
 * nothing more than an ordered pair: a nonterminal
 * attached to a string.
 */ 
 
#include "definition.h"
#include "random.h"

/**
 * Constructor: Definition
 * -----------------------
 * Constructs an instance of a Definition object
 * based on the content of the specified file.  Relies
 * on the correct implementation of the Production
 * constructor which also takes an ifstream reference.
 * The strong assumption is that the file reference is
 * poised to read the opening '{' as the very first character.
 */

Definition::Definition(ifstream& infile)
{
  string uselessText;
  getline(infile, uselessText, '{');
  infile >> nonterminal;
  getline(infile, uselessText); // stop character defaults to '\n'

  while (infile.peek() != '}') {
    Production possibleExpansion(infile);
    possibleExpansions.push_back(possibleExpansion);
  }
  
  getline(infile, uselessText, '}');
}

/**
 * Method: getRandomProduction
 * ---------------------------
 * Returns a const reference to one of the
 * embedded Productions.  Relies on the
 * correct implementation of the RandomNumberGenerator
 * class, but is otherwise a no-brainer.
 */

const Production& Definition::getRandomProduction() const
{
  static RandomGenerator random; 
  int randomIndex = random.getRandomInteger(0, possibleExpansions.size() - 1);
  return possibleExpansions[randomIndex];
}
