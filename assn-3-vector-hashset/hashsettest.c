#include "hashset.h"
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <limits.h>
#include <assert.h>

const int kNumBuckets = 26;

struct frequency {
    char ch;		// a particular letter
    int occurrences;	// the number of times it occurs
};

/**
 * Fucntion: HashFrequency
 * -----------------------
 * Hash function used to partition frequency structures into buckets.  Our
 * hash function is pretty simplistic, we simply mod the char by the
 * number of buckets.  This provides a number in the range 0 to numBuckets - 1,
 * which is the proper range for our hashset.
 */

static int HashFrequency(const void *elem, int numBuckets)
{
  struct frequency *freq = (struct frequency *)elem;
  return (freq->ch % numBuckets);
}

/**
 * Function: PrintFrequency
 * -------------------------
 * Mapping function used to print one frequency stored in a hashset.  The
 * file is passed as the client data, so that it can be used to print to
 * any FILE *.
 */

static void PrintFrequency(void *elem, void *fp)
{
  struct frequency *freq = (struct frequency *)elem;
  fprintf((FILE *)fp, "Character %c occurred %4d times\n", 
	  freq->ch, freq->occurrences);
}

/**
 * Function: CompareLetter
 * -----------------------
 * Comparator function used to compare two frequency entries within hashset.
 * Two frequencies are considered the same if they refer to the same char.
 * This function is used in HashSetLookup to decide if a char already has been
 * entered.  This function has the same return semantics as strcmp: 
 * (negative if 1<2, zero if 1==2, positive if 1>2).
 */

static int CompareLetter(const void *elem1, const void *elem2)
{
    struct frequency *freq1 = (struct frequency *)elem1;
    struct frequency *freq2 = (struct frequency *)elem2;    
    return (freq1->ch - freq2->ch);
}

/**
 * Function: CompareOccurrences
 * -----------------------------
 * Comparator function used to compare two frequency entries.  This one sorts
 * by occurrence as the primary key, and if occurrences are the same, it uses
 * the char as the secondary key, thus the call to CompareLetter which
 * compares the chars.  It "reverse-sorts" so a higher frequency bubbles to
 * the top.
 */

static int CompareOccurrences(const void *elem1, const void *elem2)
{
  struct frequency *freq1 = (struct frequency *)elem1;
  struct frequency *freq2 = (struct frequency *)elem2;
  
  if (freq1->occurrences > freq2->occurrences) return -1; 
  else if (freq1->occurrences < freq2->occurrences) return 1;
  else return CompareLetter(freq1, freq2);
}

/**
 * Function: BuildTableOfLetterCounts
 * ----------------------------------
 * Opens a file (in this case, the hashsettest.c you are currently reading).
 * and pulls characters out one by one and counts the number of times
 * each character occurs.  The frequecy information about the alphabetic
 * characters is stored in the counts hashset passed in by address.
 */

static void BuildTableOfLetterCounts(hashset *counts)
{
  struct frequency localFreq, *found;
  int ch;
  FILE *fp = fopen("hashsettest.c", "r"); // open self as file
  
  assert(fp != NULL);
  while ((ch = getc(fp)) != EOF) {
    if (isalpha(ch)) { // only count letters
      localFreq.ch = tolower(ch);
      localFreq.occurrences = 1;
      
      // See if we already have an entry for this char		
      found = (struct frequency *) HashSetLookup(counts, &localFreq);	
      if (found != NULL) 		// increment if already there 
	localFreq.occurrences = found->occurrences + 1;
      HashSetEnter(counts, &localFreq); // enter should overwrite if needed
    }
  }
  
  fclose(fp);
}

/**
 * Function: AddFrequency
 * ----------------------
 * Mapping function used to take a frequency stored 
 * in a hashset and append it to an vector of frequencies.  
 * The address of the vector is passed in as the auxiliarydata.
 */

static void AddFrequency(void *elem, void *v)
{
  VectorAppend((vector *) v, elem);
}

/**
 * Function: TestHashTable
 * -----------------------
 * Runs a test of the hashset using a frequency structure as the element 
 * type.  It will open a file, read each char, and count the number of
 * times each char occurs.  Tests enter, lookup, and mapping for the hashset. 
 * Prints contents of table to stdout.  Then it dumps all the table elements 
 * into a vector and sorts them by frequency of occurrences and 
 * prints the array out.  Note that this particular stress test passes
 * 0 as the initialAllocation, which the vector is required to handle
 * gracefully - be careful!
 */
static void TestHashTable(void)
{
  hashset counts;
  vector sortedCounts;
  
  HashSetNew(&counts, sizeof(struct frequency), kNumBuckets, HashFrequency, CompareLetter, NULL);
  
  fprintf(stdout, "\n\n ------------------------- Starting the HashTable test\n");
  BuildTableOfLetterCounts(&counts);
  
  fprintf(stdout, "Here is the unordered contents of the table:\n");
  HashSetMap(&counts, PrintFrequency, stdout);  // print contents of table
  
  VectorNew(&sortedCounts, sizeof(struct frequency), NULL, 0);
  HashSetMap(&counts, AddFrequency, &sortedCounts);   // add all freq to array
  VectorSort(&sortedCounts, CompareLetter);      // sort by char
  fprintf(stdout, "\nHere are the trials sorted by char: \n");
  VectorMap(&sortedCounts, PrintFrequency, stdout);
  
  VectorSort(&sortedCounts, CompareOccurrences); //sort by occurrences
  fprintf(stdout, "\nHere are the trials sorted by occurrence & char: \n");
  VectorMap(&sortedCounts, PrintFrequency, stdout);	// print out array 
  
  VectorDispose(&sortedCounts);				// free all storage 
  HashSetDispose(&counts);
}

int main(int ununsed, char **alsoUnused) 
{
  TestHashTable();	
  return 0;
}

