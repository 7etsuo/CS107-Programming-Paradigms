/**
 * Exposed Type: urlconnection
 * ---------------------------
 * Record bundling all of the information needed to
 * interact with web server.  The first five fields
 * store meta-information about a web document, and
 * the last field holds a FILE * referencing the
 * actual content of the web page.
 *
 * The record is exposed, but the client should respect
 * the integrity of the first five fields and not change
 * them.  The client may certainly read data from the last
 * field, but the client should not set dataStream to point
 * to anything else, and it should *never* fclose the file.
 */

#ifndef __url_connection_
#define __url_connection_

#include <stdio.h>      // for FILE *
#include "url.h"

/**
 * Exposed Type: urlconnection
 * ---------------------------
 * Record bundling everything you need to know about a remote
 * web document (be it an HTML page, an image, or a MIDI file).
 * The client declares instances of the urlconnection, but relies
 * on the URLConnectionNew and URLConnectionDispose functions to
 * initialize the fields.
 */

typedef struct {
  int responseCode;
  const char *responseMessage;
  const char *contentType;
  const char *fullUrl;
  const char *newUrl;
  FILE *dataStream;
} urlconnection;

/**
 * Function: URLConnectionNew
 * --------------------------
 * Establishes a connection to the document addressed
 * by u, and stores information about that connection
 * and the remote document in the struct addressed by
 * urlconn.
 *
 * Here's what each of the fields stores after URLConnection is called:
 *      responseCode: The code issued by the web server in response to a document request.
 *                    In general, a zero code or a code greater than or equal to 400 is bad.
 *		      Common Codes include:
 *		           0   (which means that the server name was bogus.)
 *                         200 (the document was fould and a connection was established.)
 *			   301 (the server recognizes the URL as one that used to exist, but that
 *                              the document has been permanently moved elsewhere (perhaps to a different
 *				server.)
 *                         302 (just like 301, except that there's nothing permanent about the move, so
 *                              we should NOT expect the new URL to exist forever.)
 *			   403 (we don't have permission to access the specified document)
 *			   404 (the document could not be found.)
 *      
 *      (If the response code is set to 0, then all other fields are meaningless.)
 *      responseMessage: The text message that the web server issued in response to the request for
 *			 a web document.  Messages like "OK", "Forbidden", and "Document Not Found"
 *                       are messages that typically accompany response codes of 200, 403, and 404.
 *
 *      contentType: The MIME type of the document being fetched.  Expect to see "text/html", "text/xml",
 *		     "image/jpeg", and things like that here.  They're used to identify the document
 *                   and determine which local application is best for viewing it.
 *
 *      fullUrl: The full URL of the document requested.  It should match the fullName field of the url used
 *               to establish the connection.
 *
 *      newUrl: Populated with the updated URL if a response code of 301 or 302 is returned.  We can assume that
 *              attempts to connect to this new URL will not result in any secondary redirections.
 *
 *      dataStream: Used to read in the content of the remote HTTP document.  The FILE * is normally used to read
 *                  data from a local file, but the magic of UNIX allows us to layer local file access semantics over
 *                  a network connection and to pull in remote data as if it were local.
 *      
 */

void URLConnectionNew(urlconnection* urlconn, const url* u);

/**
 * Function: URLConnection
 * -----------------------
 * Accepts the address of a previously initialized
 * urlconnection, closes the connection to the relevant
 * server, and releases all dynamically allocated strings.
 */
 
void URLConnectionDispose(urlconnection* urlconn);

#endif //__url_connection_
