#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>
#include <expat.h>

#include "url.h"
#include "bool.h"
#include "urlconnection.h"
#include "streamtokenizer.h"
#include "html-utils.h"
#include "vector.h"
#include "hashset.h"

typedef struct {
  char title[2048];
  char description[2048];
  char url[2048];
  char *activeField;
} rssFeedItem;

static void Welcome(const char *welcomeTextURL);
static void BuildIndices(const char *feedsFileURL);
static void ProcessFeed(const char *remoteDocumentURL);
static void PullAllNewsItems(urlconnection *urlconn);
static void ProcessStartTag(void *userData, const char *name, const char **atts);
static void ProcessEndTag(void *userData, const char *name);
static void ProcessTextData(void *userData, const char *text, int len);
static void ParseArticle(const char *articleTitle, const char *articleURL);
static void ScanArticle(streamtokenizer *st, const char *articleTitle, const char *articleURL);
static void QueryIndices();
static void ProcessResponse(const char *word);
static bool WordIsWellFormed(const char *word);

/**
 * Function: main
 * --------------
 * Serves as the entry point of the full RSS News Feed Aggregator.
 * 
 * @param argc the number of tokens making up the shell command invoking the
 *             application.  It should be either 1 or 2--2 when the used wants to
 *             specify what flat text file should be used to source all of the 
 *             RSS feeds.
 * @param argv the array of one of more tokens making up the command line invoking
 *             the application.  The 0th token is ignored, and the 1st one, if present,
 *             is taken to be the path identifying where the list of RSS feeds is.
 * @return always 0 if it main returns normally (although there might be exit(n) calls
 *         within the code base that end the program abnormally)
 */

static const char *const kWelcomeTextURL = "http://cs107.stanford.edu/rss-news/welcome.txt";
static const char *const kDefaultStopWordsURL = "http://cs107.stanford.edu/rss-news/stop-words.txt";
static const char *const kDefaultFeedsFileURL = "http://cs107.stanford.edu/rss-news/rss-feeds.txt";
int main(int argc, char **argv)
{
  const char *feedsFileURL = (argc == 1) ? kDefaultFeedsFileURL : argv[1];
  
  Welcome(kWelcomeTextURL);
  BuildIndices(feedsFileURL);
  QueryIndices();
  return 0;
}

/** 
 * Function: Welcome
 * -----------------
 * Displays the contents of the specified file, which
 * holds the introductory remarks to be printed every time
 * the application launches.  This type of overhead may
 * seem silly, but by placing the text in an external file,
 * we can change the welcome text without forcing a recompilation and
 * build of the application.  It's as if welcomeTextFileName
 * is a configuration file that travels with the application.
 *
 * @param welcomeTextURL the URL of the document that should be pulled
 *                       and printed verbatim.
 *
 * No return value to speak of.
 */
 
static const char *const kNewLineDelimiters = "\r\n";
static void Welcome(const char *welcomeTextURL)
{
  url u;
  urlconnection urlconn;
  
  URLNewAbsolute(&u, welcomeTextURL);
  URLConnectionNew(&urlconn, &u);
  
  if (urlconn.responseCode / 100 == 3) {
    Welcome(urlconn.newUrl);
  } else {
    streamtokenizer st;
    char buffer[4096];
    STNew(&st, urlconn.dataStream, kNewLineDelimiters, true);
    while (STNextToken(&st, buffer, sizeof(buffer))) {
      printf("%s\n", buffer);
    }  
    printf("\n");
    STDispose(&st); // remember that STDispose doesn't close the file, since STNew doesn't open one.. 
  }

  URLConnectionDispose(&urlconn);
  URLDispose(&u);
}

/**
 * Function: BuildIndices
 * ----------------------
 * As far as the user is concerned, BuildIndices needs to read each and every
 * one of the feeds listed in the specied feedsFileName, and for each feed parse
 * content of all referenced articles and store the content in the hashset of indices.
 * Each line of the specified feeds file looks like this:
 *
 *   <feed name>: <URL of remote xml document>
 *
 * Each iteration of the supplied while loop parses and discards the feed name (it's
 * in the file for humans to read, but our aggregator doesn't care what the name is)
 * and then extracts the URL.  It then relies on ProcessFeed to pull the remote
 * document and index its content.
 *
 * @param feedsFileURL the full path leading to the flat text file storing up all of the
 *                     URLs of XML RSS feeds.
 */

static const int kNumIndexEntryBuckets = 10007;
static void BuildIndices(const char *feedsFileURL)
{
  url u;
  urlconnection urlconn;
  
  URLNewAbsolute(&u, feedsFileURL);
  URLConnectionNew(&urlconn, &u);
  
  if (urlconn.responseCode / 100 == 3) { // redirection, so recurse
    BuildIndices(urlconn.newUrl);
  } else {
    streamtokenizer st;
    char remoteDocumentURL[2048];
    
    STNew(&st, urlconn.dataStream, kNewLineDelimiters, true);
    while (STSkipUntil(&st, ":") != EOF) { // ignore everything up to the first selicolon of the line
      STSkipOver(&st, ": ");		   // now ignore the semicolon and any whitespace directly after it
      STNextToken(&st, remoteDocumentURL, sizeof(remoteDocumentURL));   
      ProcessFeed(remoteDocumentURL);
    }
    
    printf("\n");
    STDispose(&st);
  }
  
  URLConnectionDispose(&urlconn);
  URLDispose(&u);
}

/**
 * Function: ProcessFeed
 * ---------------------
 * ProcessFeed locates the specified RSS document, and if a (possibly redirected) connection to that remote
 * document can be established, then PullAllNewsItems is tapped to actually read the feed.  Check out the
 * documentation of the PullAllNewsItems function for more information, and inspect the documentation
 * for ParseArticle for information about what the different response codes mean.
 */

static void ProcessFeed(const char *remoteDocumentURL)
{
  url u;
  urlconnection urlconn;
  
  URLNewAbsolute(&u, remoteDocumentURL);
  URLConnectionNew(&urlconn, &u);

  switch (urlconn.responseCode) {
      case 0: printf("Unable to connect to \"%s\".  Ignoring...", u.serverName);
              break;
      case 200: PullAllNewsItems(&urlconn);
                break;
      case 301: 
      case 302: ProcessFeed(urlconn.newUrl);
                break;
      default: printf("Connection to \"%s\" was established, but unable to retrieve \"%s\". [response code: %d, response message:\"%s\"]\n",
		      u.serverName, u.fileName, urlconn.responseCode, urlconn.responseMessage);
	       break;
  };
  
  URLConnectionDispose(&urlconn);
  URLDispose(&u);
}

/**
 * Function: PullAllNewsItems
 * --------------------------
 * Steps though the data of what is assumed to be an RSS feed identifying the names and
 * URLs of online news articles.  Check out "assn-4-rss-news-search-data/sample-rss-feed.txt"
 * for an idea of what an RSS feed from the www.nytimes.com (or anything other server that 
 * syndicates is stories).
 *
 * PullAllNewsItems views a typical RSS feed as a sequence of "items", where each item is detailed
 * using a generalization of HTML called XML.  A typical XML fragment for a single news item will certainly
 * adhere to the format of the following example:
 *
 * <item>
 *   <title>At Installation Mass, New Pope Strikes a Tone of Openness</title>
 *   <link>http://www.nytimes.com/2005/04/24/international/worldspecial2/24cnd-pope.html</link>
 *   <description>The Mass, which drew 350,000 spectators, marked an important moment in the transformation of Benedict XVI.</description>
 *   <author>By IAN FISHER and LAURIE GOODSTEIN</author>
 *   <pubDate>Sun, 24 Apr 2005 00:00:00 EDT</pubDate>
 *   <guid isPermaLink="false">http://www.nytimes.com/2005/04/24/international/worldspecial2/24cnd-pope.html</guid>
 * </item>
 *
 */

static void PullAllNewsItems(urlconnection *urlconn)
{
  rssFeedItem item;
  streamtokenizer st;
  char buffer[2048];

  XML_Parser rssFeedParser = XML_ParserCreate(NULL);
  XML_SetUserData(rssFeedParser, &item);
  XML_SetElementHandler(rssFeedParser, ProcessStartTag, ProcessEndTag);
  XML_SetCharacterDataHandler(rssFeedParser, ProcessTextData);

  STNew(&st, urlconn->dataStream, "\n", false);
  while (STNextToken(&st, buffer, sizeof(buffer))) {
    XML_Parse(rssFeedParser, buffer, strlen(buffer), false);
  }
  STDispose(&st);
  
  XML_Parse(rssFeedParser, "", 0, true);
  XML_ParserFree(rssFeedParser);  
}

/**
 * This is the function that gets invoked by the XML_Parser every time
 * it parses a start tag.  We're only interested in <item>, <title>, <description>,
 * and <link> tags.  Every time we open an item tag, we want to clear the item
 * state of the user data to contain all empty strings (which is what the memset
 * does).  Every time we open a title, description, or link tag, we update the
 * activeField field of the userData struct to address the array that should
 * be written to by the CharacterDataHandler. 
 * 
 * @param userData the address of the client data original fed to the XML_SetUserData
 *                 call within PullAllNewsItems.
 * @param name the start tag type, which could be "item", "title", description", "link"
 *             or any other null-terminated string naming a tag in the XML document
 *             being parsed.
 * @param atts an array-based map of attribute-value pairs.  We don't use this
 *             parameter here.
 *
 * No return type.
 */

static void ProcessStartTag(void *userData, const char *name, const char **atts)
{
  rssFeedItem *item = userData;
  if (strcasecmp(name, "item") == 0) {
    memset(item, 0, sizeof(rssFeedItem));
  } else if (strcasecmp(name, "title") == 0) {
    item->activeField = item->title;
  } else if (strcasecmp(name, "description") == 0) {
    item->activeField = item->description;
  } else if (strcasecmp(name, "link") == 0) {
    item->activeField = item->url;
  }
}

/**
 * This is the handler that's invoked whenever a close (explicit or implicit)
 * tag is detected.  For our purposes, we want to turn off the activeField
 * by setting it to NULL, which will be detected by the CharacterData handler
 * as an instruction to not bother writing text into the userData struct.
 * If we notice this is being invoked for an item close tag, then we take
 * the information which has been built up and stored in the userData struct
 * and use to parse and index another online news article.
 *
 * @param userData client data pointer that addresses our rssFeedItem struct.
 * @param name the end tag type, which could be "item", "title", "description", "link",
 *             or some other tag type we're not concerned with.
 */

static void ProcessEndTag(void *userData, const char *name)
{
  rssFeedItem *item = userData;
  item->activeField = NULL;
  if (strcasecmp(name, "item") == 0)
    ParseArticle(item->title, item->url);
}

/**
 * Takes the character data address by text and appends it to any previously
 * pulled text stored in the buffer addressed by the activeField of the userData
 * struct.  The text paramter is NOT NULL-terminated, so we need to rely on
 * len to know exactly how many characters to copy.  The reason we call strncat
 * instead of strncpy: the stream of text making up the full description or 
 * title or link of an RSS news feed item might be broken up across two or more
 * call backs, so our implementation needs to be sensitive to that.
 *
 * @param userData the address of the rssFeedItem struct where character data should
 *                 be copied.  Previous invocations of the ProcessStartTag handler
 *                 sets up the active field to point to the receiving buffer, but 
 *                 invocations of the ProcessEndTag handler sets that activeField field
 *                 to be NULL.  If the activeField field is non-NULL, when we know we're
 *                 appending character data to *some* character buffer.
 * @param text a pointer to a buffer of character data, which isn't NULL-terminated.
 * @param len the number of meaningful characters addressed by text.
 *
 * No return value.
 */

static void ProcessTextData(void *userData, const char *text, int len)
{
  rssFeedItem *item = userData;
  if (item->activeField == NULL) return; // no place to put data
  char buffer[len + 1];
  memcpy(buffer, text, len);
  buffer[len] = '\0';
  strncat(item->activeField, buffer, 2048);
}

/** 
 * Function: ParseArticle
 * ----------------------
 * Attempts to establish a network connect to the news article identified by the three
 * parameters.  The network connection is either established of not.  The implementation
 * is prepared to handle a subset of possible (but by far the most common) scenarios,
 * and those scenarios are categorized by response code:
 *
 *    0 means that the server in the URL doesn't even exist or couldn't be contacted.
 *    200 means that the document exists and that a connection to that very document has
 *        been established.
 *    301 means that the document has moved to a new location
 *    302 also means that the document has moved to a new location
 *    4xx and 5xx (which are covered by the default case) means that either
 *        we didn't have access to the document (403), the document didn't exist (404),
 *        or that the server failed in some undocumented way (5xx).
 *
 * The are other response codes, but for the time being we're punting on them, since
 * no others appears all that often, and it'd be tedious to be fully exhaustive in our
 * enumeration of all possibilities.
 */

static const char *const kTextDelimiters = " \t\n\r\b!@$%^*()_+={[}]|\\'\":;/?.>,<~`";
static void ParseArticle(const char *articleTitle, const char *articleURL)
{
  url u;
  urlconnection urlconn;
  streamtokenizer st;
  
  URLNewAbsolute(&u, articleURL);
  URLConnectionNew(&urlconn, &u);

  switch (urlconn.responseCode) {
      case 0: printf("Unable to connect to \"%s\".  Domain name or IP address is nonexistent.\n", articleURL);
              break;
      case 200: printf("[%s] Indexing \"%s\"\n", u.serverName, articleTitle);
	        STNew(&st, urlconn.dataStream, kTextDelimiters, false);
		ScanArticle(&st, articleTitle, articleURL);
		STDispose(&st);
		break;
      case 301: 
      case 302: // just pretend we have the redirected URL all along, though index using the new URL and not the old one...
	        ParseArticle(articleTitle, urlconn.newUrl);
		break;
      default: printf("Unable to pull \"%s\" from \"%s\". [Response code: %d] Punting...\n", articleTitle, u.serverName, urlconn.responseCode);
	       break;
  }
  
  URLConnectionDispose(&urlconn);
  URLDispose(&u);
}

/**
 * Function: ScanArticle
 * ---------------------
 * Parses the specified article, skipping over all HTML tags, and counts the numbers
 * of well-formed words that could potentially serve as keys in the set of indices.
 * Once the full article has been scanned, the number of well-formed words is
 * printed, and the longest well-formed word we encountered along the way
 * is printed as well.
 *
 * This is really a placeholder implementation for what will ultimately be
 * code that indexes the specified content.
 */

static void ScanArticle(streamtokenizer *st, const char *articleTitle, const char *articleURL)
{
  int numWords = 0;
  char word[1024];
  char longestWord[1024] = {'\0'};

  while (STNextToken(st, word, sizeof(word))) {
    if (strcasecmp(word, "<") == 0) {
      SkipIrrelevantContent(st); // in html-utls.h
    } else {
      RemoveEscapeCharacters(word);
      if (WordIsWellFormed(word)) {
	numWords++;
	if (strlen(word) > strlen(longestWord))
	  strcpy(longestWord, word);
      }
    }
  }

  printf("\tWe counted %d well-formed words [including duplicates].\n", numWords);
  printf("\tThe longest word scanned was \"%s\".", longestWord);
  if (strlen(longestWord) >= 15 && (strchr(longestWord, '-') == NULL)) 
    printf(" [Ooooo... long word!]");
  printf("\n");
}

/** 
 * Function: QueryIndices
 * ----------------------
 * Standard query loop that allows the user to specify a single search term, and
 * then proceeds (via ProcessResponse) to list up to 10 articles (sorted by relevance)
 * that contain that word.
 */
static void QueryIndices()
{
  char response[1024];
  while (true) {
    printf("Please enter a single query term that might be in our set of indices [enter to quit]: ");
    fgets(response, sizeof(response), stdin);
    response[strlen(response) - 1] = '\0';
    if (strcasecmp(response, "") == 0) break;
    ProcessResponse(response);
  }
}

/** 
 * Function: ProcessResponse
 * -------------------------
 * Placeholder implementation for what will become the search of a set of indices
 * for a list of web documents containing the specified word.
 */

static void ProcessResponse(const char *word)
{
  if (WordIsWellFormed(word)) {
    printf("\tWell, we don't have the database mapping words to online news articles yet, but if we DID have\n");
    printf("\tour hashset of indices, we'd list all of the articles containing \"%s\".\n", word);
  } else {
    printf("\tWe won't be allowing words like \"%s\" into our set of indices.\n", word);
  }
}

/**
 * Predicate Function: WordIsWellFormed
 * ------------------------------------
 * Before we allow a word to be inserted into our map
 * of indices, we'd like to confirm that it's a good search term.
 * One could generalize this function to allow different criteria, but
 * this version hard codes the requirement that a word begin with 
 * a letter of the alphabet and that all letters are either letters, numbers,
 * or the '-' character.  
 */

static bool WordIsWellFormed(const char *word)
{
  int i;
  if (strlen(word) == 0) return true;
  if (!isalpha((int) word[0])) return false;
  for (i = 1; i < strlen(word); i++)
    if (!isalnum((int) word[i]) && (word[i] != '-')) return false; 

  return true;
}
