#include "bool.h"
#include "hashset.h"
#include "vector.h"
#include "streamtokenizer.h"
#include <stdlib.h>  // for malloc, free, etc
#include <string.h>  // for strcmp
#include <strings.h>
#include <ctype.h>   // for tolower
#include <time.h>    // for time

/**
 * Convenience struct used to bundle a word (expressed 
 * as a dynamically allocated C string) with the list
 * of all of its synonyms (stored in a C vector of
 * dynamically allocated C strings).
 */

typedef struct {
  char *word;
  vector synonyms;
} thesaurusEntry;

/**
 * Hash function provided by the goddess of lecturing,
 * Julie Zelenski.  I'm not sure where it came from, but
 * I'm guessing the multiplier is standard.
 *
 * @param elem a void * which is understood to be the address
 *             of a char *, which itself addresses the first of
 *             a series of characters making up a C string.
 * @param numBuckets the number of buckets in the hash table.
 * @return the hashcode of the C string addressed by elem.
 */

static const signed long kHashMultiplier = -1664117991L;
static int StringHash(const void *elem, int numBuckets)
{
  char *s = *(char **) elem;
  unsigned long hashcode = 0;
  for (int i = 0; i < strlen(s); i++)  
    hashcode = hashcode * kHashMultiplier + tolower(s[i]);  
  return hashcode % numBuckets;                                  
}

/**
 * Compares the two C strings planted at the specified addresses.
 * elem1 and elem2 are statically identified as void *s, but 
 * we know that they're really char **s.  We cast and deferences
 * to arrive at char *s, and let strcmp do the traditional comparison
 * and use its return value as our own.
 *
 * @param elem1 the address of a char *, which itself addresses a null-terminated
 *              character array.
 * @param elem2 the address of a char *, just like elem1.
 * @return an integer representing the difference between the ASCII values of the
 *         first non matching characters, or 0 if the two strings are equal.
 */

static int StringCompare(const void *elem1, const void *elem2)
{
  return strcmp(*(const char **) elem1, *(const char **) elem2);
}

/**
 * Properly disposes of the thesaurusEntry understood to
 * sit at the specified address.  Note that the synonyms
 * vector already knows how to dispose of all of its strings,
 * so the call to VectorDispose is sufficient.
 *
 * @param elem the address of the thesaurusEntry being freed.
 *
 * No return value to speak of.
 */

static void ThesEntryFree(void *elem)
{
  thesaurusEntry *entry = elem;
  free(entry->word);
  VectorDispose(&entry->synonyms);
} 

/**
 * Disposes of the char * addressed by elem.  Simple
 * wrapper to free.
 * 
 * @param elem
 */

static void StringFree(void *elem)
{
  free(*(void **)elem);
}

/**
 * Tokenizes the flat text thesaurus underneath the specified streamtokenizer,
 * and builds up the specified thesaurus out of the information.  Each
 * line of the flat text thesaurus file is of the form:
 *
 *     cold,arctic,blustery,freezing,frigid,icy,nippy,polar
 *
 * The first word is the primary word, and all other words are considered to
 * be synonyms (or closely related words) of the first.  The ',' delimits
 * all words, and the '\n' marks the end of the synonym list.  We assume
 * that each line has at least one word, and the code below even deals with
 * the unlikely scenario that there are zero synonyms.
 *
 * @param thesuarus the address of the thesaurus of thesaurusEntry records to which
 *                  all of the synonym data should be added.
 * @param st the address of the streamtokenizer layering over the flat text thesaurus
 *           file.
 */

static void TokenizeAndBuildThesaurus(hashset *thesaurus, streamtokenizer *st)
{
  printf("Loading thesaurus. Be patient! ");
  fflush(stdout);

  char buffer[2048];
  while (STNextToken(st, buffer, sizeof(buffer))) {
    thesaurusEntry entry;
    entry.word = strdup(buffer);
    VectorNew(&entry.synonyms, sizeof(char *), StringFree, 4);
    while (STNextToken(st, buffer, sizeof(buffer)) && (buffer[0] == ',')) {
      STNextToken(st, buffer, sizeof(buffer));
      char *synonym = strdup(buffer);
      VectorAppend(&entry.synonyms, &synonym);
    }
    HashSetEnter(thesaurus, &entry);
    if (HashSetCount(thesaurus) % 1000 == 0) {
      printf(".");
      fflush(stdout);
    }
  }

  printf(" [All done!]\n");
  fflush(stdout);
}

/**
 * Higher-level function that confirms that the flat text file actually
 * exists and can be opened.  If successful, ReadThesaurus layers a
 * streamtokenizer over the file, passes the buck to TokenizeAndBuildThesaurus,
 * and then kills the streamtokenizer and the stream.
 *
 * @param thesuarus the address of the thesaurus of thesaurusEntry records to which
 *                  all of the synonym data should be added.
 * @param filename the name of the flat text file of thesaurus data.
 */

static void ReadThesaurus(hashset *thesaurus, const char *filename)
{
  FILE *infile = fopen(filename, "r");
  if (infile == NULL) {
    fprintf(stderr, "Could not open thesaurus file named \"%s\"\n", filename);
    exit(1);
  }
  
  streamtokenizer st;
  STNew(&st, infile, ",\n", false);
  TokenizeAndBuildThesaurus(thesaurus, &st);
  STDispose(&st);
  fclose(infile);
}

/**
 * Based on the function in Eric Robert's The Art and Science of C,
 * it returns a randomly generated number in the range [low, high],
 * with all return values being equally likely.
 *
 * @param low the lowest number of interest.
 * @param high the highest value of interest.
 * @return a number drawn uniformly from [low, high].
 */

static int RandomInteger(int low, int high)
{
  static bool randomized = false;
  if (!randomized) {
    srand(time(NULL));
    randomized = true;
  }
  
  double percent = rand()/((double) RAND_MAX + 1);
  int offset = (high - low + 1) * percent;
  return low + offset;
}

/**
 * Simple question loop that prompts the user for a word, and
 * then looks up the word in the thesaurus.  If present, it
 * selects one of the its synonyms at random, printing it along
 * with the user supplied word.
 *
 * @param thesuarus the address of the hashset housing all of the
 *                  synonyms sets of a large collection of English
 *                  words and phrases.
 */

static void QueryThesaurus(hashset *thesaurus)
{
  char response[1024];
  char *responsep = response;
  while (true) {
    printf("Go ahead and enter a word: ");
    fgets(response, sizeof(response), stdin);
    response[strlen(response) - 1] = '\0';
    if (strlen(response) == 0) return;
    thesaurusEntry *found = HashSetLookup(thesaurus, &responsep);
    if (found != NULL) {
      int numSynonyms = VectorLength(&found->synonyms);
      char *synonym = *(char **) VectorNth(&found->synonyms, RandomInteger(0, numSynonyms - 1));
      printf("We found \"%s\" in the thesaurus! Its related word of the day is \"%s\".\n", response, synonym);
    } else {
      printf("My apologies, but I know of no such word spelled \"%s\".\n", response);
    }
  }
}

/**
 * Provides the enty point to the program.
 */

static const int kApproximateWordCount = (1 << 19) - 1; // six-digit Marsenne prime
int main(int argc, const char *argv[])
{
  hashset thesaurus;
  HashSetNew(&thesaurus, sizeof(thesaurusEntry), kApproximateWordCount, StringHash, StringCompare, ThesEntryFree);
  const char *thesaurusFileName = (argc == 1) ? 
    "/usr/class/cs107/assignments/assn-3-vector-hashset-data/thesaurus.txt" : argv[1];
  ReadThesaurus(&thesaurus, thesaurusFileName);
  QueryThesaurus(&thesaurus);
  HashSetDispose(&thesaurus);
  return 0;
}
