#ifndef _htmlutils_
#define _htmlutils_

#include "bool.h"
#include "streamtokenizer.h"

/**
 * Function: RemoveEscapeCharacters
 * --------------------------------
 * Takes the null-terminated C string inside the text array
 * and replaces all HTML escape sequences with their single
 * character equivalents.  Escape sequences always begin
 * with a '&' and typically end with a ';'.  Each substring
 * maps to a clearly defined character.
 *
 * Examples: "Sonny &amp; Cher" should really be "Sonny & Cher".
 *           "Zadie Smith&#39;s &quot;On Beauty&quot;" should really be "Zadie Smith's \"On Beauty\""
 */

void RemoveEscapeCharacters(char text[]);

/**
 * Function: GetNextTag
 * --------------------
 * Pulls the next html tag ('<' through and including '>') 
 * from the stream controlled by the streamtokenizer.  Any text 
 * up to the '<' is skipped and discarded.  true is returned if and
 * only if the buffer was truly populated with an HTML tag.
 */

bool GetNextTag(streamtokenizer *st, char htmlBuffer[], int htmlBufferLength);


/**
 * Function: SkipIrrelevantContent
 * -------------------------------
 * Operates on the assumption that "<" has just
 * been pulled from the specified streamtokenizer, and that
 * we're interested in pulling everything up through the
 * balancing ">".  This is complicated by the fact that
 * the "<" just pulled may be the beginning of an HTML
 * comment tag, in which case we'd like to skip through
 * any and all intervening text (including some standalone
 * '>' characters) until we find the "-->" that marks
 * the comment's end.
 *
 * It also skips potentially huge segments of content.  If
 * the HTML tag read right up front begins with "<script" or
 * with "<style", then we skip more than the tag; we actually
 * skip everything through the matching </script> or </style>.
 * Material sitting beneath the script and the style nodes 
 * within the HTML tree isn't text; it's either Javascript
 * or CSS, and neither should be considered when building the
 * indices.
 */

void SkipIrrelevantContent(streamtokenizer *st);

#endif
