/**
 * File: word-games.cc
 * -------------------
 * Here's a program that allows the user to list
 * all words in the Engish language containing a set
 * of letters.  Curious if there are any words with
 * a, b, c, d, e, and f?  Just ask.  Want to know
 * if there are any words containing all six vowels? 
 * You can find that out as well!  Woo.
 */

#include <vector>
#include <iostream>
#include <fstream>
#include <iomanip>
using namespace std;

static void loadWords(vector<string>& words,
		      const char *wordsFile = "/usr/class/cs107/assignments/assn-0-small-programs-data/words.txt");
static void playWordGames(const vector<string>& words);
static bool isLegitimateResponse(const string& response);
static void listWordsContaining(const vector<string>& words, const string& letters);
static bool wordContainsAllLetters(const string& word, const string& letters);

/**
 * Provides the entry point for the word-games
 * application.  Not much happens here: we
 * set aside space for an STL vector of strings,
 * populate it with all the words in the specified
 * data file (the name of which is supplied as a default
 * via the prototypes).
 *
 * @param argc unused
 * @param argv unused
 * @return 0, unless the program fails because the words.txt file
 *         isn't where it's supposed to be, in which case main
 *         doesn't really return.
 */

int main(int argc, char **argv)
{
  vector<string> words;
  loadWords(words);
  playWordGames(words);
  return 0;
}

/**
 * Opens the specified file, provided it exists, and then
 * reads in the words, one at a time, and populates the
 * supplied vector of strings.  We assume the words vector
 * is initially empty.
 *
 * @param words the vector where words should be stored.
 * @param wordsFile the name of the file containing all of the
 *                  words in the English language.
 */

static void loadWords(vector<string>& words, const char *wordsFile)
{
  ifstream infile;
  infile.open(wordsFile);
  if (infile.fail()) {
    cerr << "Failed to open file named \"" << wordsFile << "\"" << endl;
    exit(1);
  }
  
  while (true) {
    string word;
    getline(infile, word);
    if (infile.eof()) break;
    words.push_back(word);
  }
  
  infile.close();
}

/**
 * Interacts with the user via the traditional query loop.
 * The user types in characters, and helper functions
 * list all of the words containing all of those characters.
 *
 * Note that words is a reference to a const vector<string>.
 * That just means that the vector is treated as a constant, and
 * the code promises to not change it.
 *
 * @param words a reference to a vector of English words (read-only)
 */

static void playWordGames(const vector<string>& words)
{
  while (true) {
    cout << "Please enter a string of characters: ";
    string response;
    getline(cin, response);
    if (response == "") break;
    if (isLegitimateResponse(response)) {
      listWordsContaining(words, response);
    } else {
      cout << "We didn't like one or more of those characters.  Let's try that again" << endl;
    }
  }
}

/**
 * Returns true if and only if the specified string
 * is comprised of lower case letters and nothing else.
 *
 * @param response the string being examined.
 * @param true if response contains just lower case letters, and
 *        false otherwise.
 */

static bool isLegitimateResponse(const string& response)
{
  for (unsigned int i = 0; i < response.size(); i++) {
    if (!isalpha(response[i]) || !islower(response[i])) 
      return false;
  }
  
  return true;
}

/**
 * Lists all of the words in the specified vector<string> which
 * happen to contain all characters in the specified letters string.
 *
 * @param words a reference to a (read-only) vector of English words.
 * @param letters a string containing all letters than need to be present
 *        in a word if it's to be printed.
 */

static void listWordsContaining(const vector<string>& words, const string& letters)
{
  string header = "The following English words contain all of the letters in \"" + letters + "\"";
  string divider(header.size(), '-');
  
  cout << header << endl << divider << endl << endl;
  for (unsigned int i = 0; i < words.size(); i++) {
    if (wordContainsAllLetters(words[i], letters))
      cout << "   " << words[i] << endl;
  }
  cout << endl;
}

/**
 * Returns true if and only if every character within letters appears
 * somewhere in word.
 *
 * @param word an arbirary string.
 * @param letters a collection of characters, expressed as a C++ string.
 * @return true if any only if the specified word contains all characters
 *         in the letters string.
 */

static bool wordContainsAllLetters(const string& word, const string& letters) 
{
  for (unsigned int i = 0; i < letters.size(); i++) {
    if (word.find(letters[i]) == string::npos)
      return false;
  }
  
  return true;
}

