#include "streamtokenizer.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include <assert.h>

void STNew(streamtokenizer *st, FILE *infile, const char *delimiters, bool discardDelimiters)
{
  assert(infile != NULL);
  assert(delimiters != NULL);
  assert(strlen(delimiters) > 0);
  
  st->infile = infile;
  st->discardDelimiters = discardDelimiters;
  st->delimiters = strdup(delimiters);
}

void STDispose(streamtokenizer *st)
{
  free((void *) st->delimiters);  // donates the memory allocated by strdup back to the heap
}

bool STNextToken(streamtokenizer *st, char buffer[], int bufferLength)
{
	return STNextTokenUsingDifferentDelimiters(st, buffer, bufferLength, st->delimiters);
}

bool STNextTokenUsingDifferentDelimiters(streamtokenizer *st, char buffer[], int bufferLength, const char *delimiters)
{
  int i;
  int next;
  
  assert(buffer != NULL);
  assert(bufferLength >= 2);
  
  if (st->discardDelimiters) STSkipOver(st, delimiters);
  next = getc(st->infile);
  if (next == EOF) return false;
  buffer[0] = next;
  if (strchr(delimiters, next) != NULL) {
    buffer[1] = '\0';
    return true;
  }
  
  // pull characters until hit stop character, or until buffer is full
  for (i = 1; i < bufferLength - 1; i++) { // leave room for '\0'
    next = fgetc(st->infile);
    if (next == EOF) break;
    if (strchr(delimiters, next) != NULL) {
      ungetc(next, st->infile);
      break;
    }
    
    buffer[i] = next; 
  }
  
  // i indexes place where null-term should be placed...
  buffer[i] = '\0';
  return true;
}

static bool HaveReasonToStop(const char *charSet, int next, bool skipping)
{
  bool inSet = (strchr(charSet, next) != NULL);
  return ((inSet && !skipping) || (!inSet && skipping));
}

static int STSkipHelper(streamtokenizer *st, const char *charSet, bool skipping)
{
  int next;
  
  while (true) {
    next = getc(st->infile);
    if (next == EOF) return EOF;
    if (HaveReasonToStop(charSet, next, skipping)) break;
  }
  
  ungetc(next, st->infile); 
  return next;
}

int STSkipUntil(streamtokenizer *st, const char *skipUntilSet)
{
  return STSkipHelper(st, skipUntilSet, false);
}

int STSkipOver(streamtokenizer *st, const char *skipSet)
{
  return STSkipHelper(st, skipSet, true);
}
