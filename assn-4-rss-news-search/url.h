/** 
 * File: url.h
 * -----------
 * Exports the url type.
 */

#ifndef __url_
#define __url_

/**
 * Exposed struct: url
 * -------------------
 * Manages all of the various components of a full URL.
 * The client should initialize a url instance using either
 * URLNewAbsolute or URLNewRelative, and then treat each of
 * the four fields as read only.  The client should rely
 * on URLDispose to release the three strings embedded inside.
 */

typedef struct {
  const char *fullName;
  const char *serverName;
  const char *fileName;
  unsigned short port;
} url;

/**
 * Function: URLNewAbsolute
 * Usage: URLNewAbsolute(&myFriendsBlog, "adam.gillitt.com");
 * ----------------------------------------------------------
 * Accepts the address of a presumably raw url struct, and populates
 * its four fields based on the contents of the absolute path.  The
 * assumption is that the resource is accessible via an HTTP server, unless
 * some other protocol prefixes the absolute path.  At the moment, we only
 * support http, though future iterations might support https and ftp.
 * So the "http://" at the front is completely optional.  We assume by default
 * that all HTTP servers listen to port 80.
 *
 * URLNewAbsolute(&stanfordDeptsURL, "http://www.stanford.edu/home/academics/departments.html");
 * URLNewAbsolute(&stanfordDeptsURL, "www.stanford.edu/home/academics/departments.html");
 *
 *    Either one of the above would initialize stanfordDeptsURL to be:
 *
 *            { 
 *              "www.stanford.edu/home/academics/departments.html",
 *              "www.stanford.edu",
 *              "home/academics/departments.html",
 *              80 
 *            }
 *
 * URLNewAbsolute(&kottkeURL, "http://www.kottke.org"); 
 * 
 *    The above populates kottkeURL with 
 *
 *            {
 *              "www.kottke.org",
 *              "www.kottke.org",
 *              "",
 *              80
 *            }
 */

void URLNewAbsolute(url *u, const char *absolutePath);

/**
 * Function: URLNewRelative
 * Usage: URLNewRelative(&kottkeContactURL, &kottkeURL, "/about/contact.html");
 * ----------------------------------------------------------------------------
 * Initializes the contents of the first url from the information embedded within
 * the parentURL and the relativePath string. 
 *
 * URLNewRelative(&kottkeContactURL, &kottkeURL, "/about/contact.html");
 *
 *    Assuming that kottkeURL was initialized from "http://www.kottke.org",
 *    the above would initialize kottkeContactURL to:
 *
 *            {
 *              "www.kottke.org/about/contact.html",
 *              "www.kottke.org",
 *              "about/contact.html",
 *              80
 *            }
 *
 * If the relative path is actually an absolute path, then the information
 * within the parentURL is ignored and the url address by u is initialized
 * as if URLNewAbsolute(u, relativePath) were called.  So... 
 *
 * URLNewRelative(&bookURL, &amazonTop25FictionURL, "http://www.kiterunner.com/nytimesReview.html");
 * would result in bookURL being set to contain:
 *
 *            {
 *              "www.kiterunner.com/nytimesReview.html"
 *              "www.kiterunner.com",
 *              "nytimesReview.html",
 *              80
 *            }
 */

void URLNewRelative(url *u, const url *parentURL, const char *relativePath);

/**
 * Function: URLDispose
 * Usage: URLDispose(&myFriendsBlog);
 * ---------------------------------
 * Frees all external resources embedded inside the specified url.
 */

void URLDispose(url *u);

#endif
