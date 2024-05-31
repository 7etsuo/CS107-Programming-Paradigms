#ifndef _streamtokenizer_
#define _streamtokenizer_

#include "bool.h"
#include <stdio.h>

/**
 * Type: streamtokenizer
 * ---------------------
 * A streamtokenizer is a C struct that helps
 * manage the parsing of a input stream.  The same
 * code pattern comes up again and again within
 * any program that uses the streamtokenizer type.
 * The following function, for instance, would print
 * all of the readable words to standard output.
 *
 *     static const char *const kWhiteSpaceCharacters = " \t\n\r";
 *     void PrintAllWords(FILE *infile)
 *     {
 *         streamtokenizer st;
 *         char word[128];  // reasonable upper limit on length of all English words..
 *         STNew(&st, infile, kWhiteSpaceCharacters, true);
 *         while (STNextToken(&st, word, sizeof(word)) {
 *             printf("%s\n", word);
 *         }
 *         STDispose(&st);
 *     }
 *
 * The body of the while loop certainly did not need to be as simple as this.
 * It could do anything at all with the token that populates the client-supplied
 * character buffer called word.
 *
 * Note that the client should not at all access the three fields of
 * streamtokenizer directly.  The only reason you see them here is because
 * there's no easy way to hide them in C.  You should pretend that they've
 * been marked as private.  Let the implementations of all the streamtokenizer
 * functions manage the fields for you.
 */

typedef struct {
  FILE *infile;
  const char *delimiters;
  bool discardDelimiters;
} streamtokenizer;

/**
 * Function: STNew
 * ---------------
 * Initializes the specified streamtokenizer to
 * encapsulate whatever stream is accessible 
 * via the specified file name.  By default, 
 * the streamtokenizer treats all characters 
 * of the delimiters string as delimiters, and
 * the streamtokenizer returns individual delimiters as
 * one-character strings if and only if discardDelimiters 
 * is set to false.  Delimiters are otherwise skipped
 * and never contribute to a token.
 * 
 * The function asserts the following conditions are
 * met:
 *     
 *        The infile stream is non-NULL.
 *        The delimiter string is non-NULL.
 *        The delimiter string isn't the empty string.
 */

void STNew(streamtokenizer *st, FILE *infile, const char *delimiters, bool discardDelimiters);

/**
 * Function: STDispose
 * -------------------
 * Properly disposes of any resources acquired by
 * STNew.  The FILE * passed to STInitialize is 
 * *not* closed, because STInitialize didn't open any
 * files.
 */

void STDispose(streamtokenizer *st);

/**
 * Function: STNextToken
 * ---------------------
 * Scans characters from the file to form a string in the client-supplied
 * character buffer. The client must pass a buffer which is valid storage and 
 * give the length of the buffer in the bufferLength parameter.  This function
 * extracts the next token from the streamtokenizer and writes it into the buffer.
 * The token written into the buffer is null-terminated.
 *
 * Return value:
 *   STNextToken returns a boolean result which indicates whether anything was
 *   written into the buffer. If a valid (i.e. non-empty) token was found
 *   and written into the client's buffer, the function returns true. If
 *   the scanner is at EOF and there are no more tokens to read (or if the
 *   the only characters left are delimiters and they are being discarded),
 *   it will return false.  Think of the boolean result as communicating to
 *   the client whether there was a token written into the buffer that needs to
 *   be processed. If the tokenizer places a token, it returns true, false 
 *   otherwise. Note that if the streamtokenizer reads the last token and stops at EOF
 *   it still returns true (since a token was written to buffer), but the next
 *   call to STNextToken will return false (since there are no tokens left).
 *
 * How it forms tokens:
 *   STNextToken starts by examining the next character in the file.  If
 *   the char is a member of the delimiter set, a single-character string 
 *   of just that delimiter will be formed. If discardDelimiters is false,
 *   it returns it. If discardDelimiters is true, the delimiter token is 
 *   discarded and it continues on looking for a non-delimiter token.  When a 
 *   non-delimiter character is found, it keeps scanning characters and 
 *   accumulating a multi-character token into the client buffer until the 
 *   first delimiter character (or EOF) is seen.  The stopping delimiter 
 *   char is left in the input stream for next time.
 *
 * What happens when client buffer is full:
 *   The client provides the buffer and indicates how big it is. If while
 *   reading a token, the tokenizer exhausts the buffer before end of the token,
 *   it truncates to what fits in the client buffer (leaving space to null-
 *   terminate). The next call to STToken will pick up where it left off.
 *   Thus, long tokens are chopped into pieces.  No error message is printed or
 *   assert raised when this happens. For example, if chars coming are
 *   "antidisestablishmentarianism" and the clients scans into a 10-char buffer,
 *   it would first pull out "antidises", then "tablishme", etc.
 *
 * STNextToken asserts that the following conditions are met:
 *
 *       The specified buffer is legitimate (non-NULL) storage.
 *       The specified buffer length is 2 or more.
 */

bool STNextToken(streamtokenizer *st, char buffer[], int bufferLength);

/**
 * Function: STNextTokenUsingDifferentDelimiters
 * ---------------------------------------------
 * Operates exactly the same as STNextToken, except that this time
 * the client gets to specify exactly which delimiters should be used
 * as stop characters.  Note that this does NOT change the default delimiter
 * set normally used by the streamtokenizer.  This is just a one-time
 * deal where we allow the user to override the delimiter set specified
 * when STNew was called.  This is particularly useful when the client has
 * a clear idea as to how the data stream is formatted.  Note, however,
 * the the client cannot change whether or not the delimiters should be
 * discarded or not.
 */
 
bool STNextTokenUsingDifferentDelimiters(streamtokenizer *st, char buffer[], int bufferLength,
										 const char *delimiters);

/**
 * Function: STSkipOver
 * --------------------
 * Pulls characters off the specified stream and continues to
 * pull until it hits a character not in the specified skipSet.
 * There is no limit to the number of characters that can be skipped, 
 * and the stopping character (or EOF if the end of stream is reached)
 * is returned so that the client has some information about
 * what character prompted STSkipOver to exit.  The stop character
 * is left on the stream and will be considered by the very next
 * call to a streamtokenizer function.
 * 
 * For example, if the skipSet were "abcde", and then next 
 * seven characters in the file stream were "abccdefda", the
 * streamtokenizer would skip through and discard the first six characters, 
 * set the streamtokenizer to point to the 'f', and would return the 'f'
 * as the character that prompted STSkipOver to exit.  The next call
 * to STNextToken, STSkipOver, or STSkipUntil would pull the 'f' as
 * the very first character.
 *
 * Note that the STSkipOver function returns an int, not a char.
 * EOF is #defined to be the four-byte representation of -1.  We
 * need to return a sentinel outside the range of normal characters,
 * because any legitimate char could otherwise be the stopping character.
 * The int can be safely truncated to a char once you've confirmed that
 * it isn't EOF.
 *
 *     char stopChar;
 *     int stopCharAsInt = STSkipOver(&myStreamTokenizer, "aeiou");
 *     if (stopCharAsInt == EOF) {
 *          fprintf(stderr, "End of file reached prematurely.\n");
 *          exit(1);
 *     } 
 *     
 *     stopChar = stopCharAsInt;  // truncates
 *     // process stopChar if needed
 */

int STSkipOver(streamtokenizer *st, const char *skipSet);

/*
 * Function: STSkipUntil
 * ---------------------
 * Operates just like the STSkipOver function, save for the fact
 * that it keeps skipping characters until it hits a character
 * within the specified character set.  The blocking character
 * is returned, unless the end-of-file marker was reached, in 
 * which case EOF is returned instead.
 */

int STSkipUntil(streamtokenizer *st, const char *skipUntilSet);

#endif
