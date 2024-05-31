#ifndef __hashset_
#define __hashset_
#include "vector.h"

/* File: hashtable.h
 * ------------------
 * Defines the interface for the hashset.
 */

/**
 * Type: HashSetHashFunction
 * -------------------------
 * Class of function designed to map the figure at the specied
 * elemAddr to some number (the hash code) between 0 and numBuckets - 1.
 * The hashing routine must be stable in that the same number must
 * be returned every single time the same element (where same is defined
 * in the HashSetCompareFunction sense) is hashed.  Ideally, the
 * hash routine would manage to distribute the spectrum of client elements
 * as uniformly over the [0, numBuckets) range as possible.
 */

typedef int (*HashSetHashFunction)(const void *elemAddr, int numBuckets);

/**
 * Type: HashSetCompareFunction
 * ----------------------------
 * Class of function designed to compare two elements, each identified
 * by address.  The HashSetCompareFunction compares these elements and
 * decides whether or not they are logically equal or or.  The
 * return value identifies relative ordering:
 * 
 *   - A negative return value means that the item addressed by elemAddr1
 *     is less than the item addressed by elemAddr2.  The definition of
 *     'less than' is dictated by the implementation's interpretation of the data.
 *   - A zero return value means that the two items addressed by elemAddr1
 *     and elemAddr2 are equal as far as the comparison routine is concerned.
 *   - A positive return value means that the item addressed by elemAddr2
 *     is less that the item addressed by elemAddr1.
 */

typedef int (*HashSetCompareFunction)(const void *elemAddr1, const void *elemAddr);

/**
 * Type: HashSetMapFunction
 * ------------------------
 * Class of function that can me mapped over the elements stored in a hashset.
 * These map functions accept a pointer to a client element and a pointer
 * to a piece of auxiliary data passed in as the second argument to HashSetMap.
 */

typedef void (*HashSetMapFunction)(void *elemAddr, void *auxData);

/**
 * Type: HashSetFreeFunction
 * -------------------------
 * Class of functions designed to dispose of and/or clean up
 * any resources embedded within the element at the specified
 * address.  Typically, such resources are dynamically allocated
 * memory, open file pointers, and data structures requiring that
 * some specific cleanup routine be called.
 */

typedef void (*HashSetFreeFunction)(void *elemAddr);

/**
 * Type: hashset
 * -------------
 * The concrete representation of the hashset.
 * In spite of all of the fields being publicly accessible, the
 * client is absolutely required to initialize, dispose of, and
 * otherwise interact with all hashset instances via the suite
 * of the six hashset-related functions described below.
 */

typedef struct {
  vector *buckets;
  int numBuckets;
  int elemSize;
  int elemCount;
  HashSetHashFunction hashfn;
  HashSetCompareFunction comparefn;
} hashset;

/**
 * Function:  HashSetNew
 * ---------------------
 * Initializes the identified hashset to be empty.  It is assumed that
 * the specified hashset is either raw memory or one previously initialized
 * but later destroyed (using HastSetDispose.)
 * 
 * The elemSize  parameter specifies the number of bytes that a single element of the
 * table should take up. For example, if you want to store elements of type 
 * Binky, you would pass sizeof(Binky) as this parameter. An assert is
 * raised if this size is less than or equal to 0.
 *
 * The numBuckets parameter specifies the number of buckets that the elements
 * will be partitioned into.  Once a hashset is created, this number does
 * not change.  The numBuckets parameter must be in sync with the behavior of
 * the hashfn, which must return a hash code between 0 and numBuckets - 1.   
 * The hashfn parameter specifies the function that is called to retrieve the
 * hash code for a given element.  See the type declaration of HashSetHashFunction
 * above for more information.  An assert is raised if numBuckets is less than or
 * equal to 0.
 *
 * The comparefn is used for testing equality between elements.  See the
 * type declaration for HashSetCompareFunction above for more information.
 *
 * The freefn is the function that will be called on an element that is
 * about to be overwritten (by a new entry in HashSetEnter) or on each element 
 * in the table when the entire table is being freed (using HashSetDispose).  This 
 * function is your chance to do any deallocation/cleanup required,
 * (such as freeing any pointers contained in the element). The client can pass 
 * NULL for the freefn if the elements don't require any handling. 
 * An assert is raised if either the hash or compare functions are NULL.
 *
 * An assert is raised unless all of the following conditions are met:
 *    - elemSize is greater than 0.
 *    - numBuckets is greater than 0.
 *    - hashfn is non-NULL
 *    - comparefn is non-NULL
 */

void HashSetNew(hashset *h, int elemSize, int numBuckets, 
		HashSetHashFunction hashfn, HashSetCompareFunction comparefn, HashSetFreeFunction freefn);

/**
 * Function: HashSetDispose
 * ------------------------
 * Disposes of any resources acquired during the lifetime of the
 * hashset.  It does not dispose of client elements properly unless the
 * HashSetFreeFunction specified at construction time does the right
 * thing.  HashSetDispose will apply this cleanup routine to all
 * of the client elements stored within.
 *
 * Once HashSetDispose has been called, the hashset is rendered
 * useless.  The diposed of hashset should not be passed to any
 * other hashset routines (unless for some reason you want to reuse
 * the same hashset variable and re-initialize is by passing it to
 * HashSetNew... not recommended.)
 */

void HashSetDispose(hashset *h);

/**
 * Function: HashSetCount
 * ----------------------
 * Returns the number of elements residing in 
 * the specified hashset.
 */

int HashSetCount(const hashset *h);

/**
 * Function: HashSetEnter
 * ----------------------
 * Inserts the specified element into the specified
 * hashset.  If the specified element matches an
 * element previously inserted (as far as the hash
 * and compare functions are concerned), the the
 * old element is replaced by this new element.
 *
 * An assert is raised if the specified address is NULL, or
 * if the embedded hash function somehow computes a hash code
 * for the element that is out of the [0, numBuckets) range.
 */

void HashSetEnter(hashset *h, const void *elemAddr);

/**
 * Function: HashSetLookup
 * -----------------------
 * Examines the specified hashset to see if anything matches
 * the item residing at the specified elemAddr.  If a match
 * is found, then the address of the stored item is returned.
 * If no match is found, then NULL is returned as a sentinel.
 * Understand that the key (residing at elemAddr) only needs
 * to match a stored element as far as the hash and compare
 * functions are concerned.
 *
 * An assert is raised if the specified address is NULL, or
 * if the embedded hash function somehow computes a hash code
 * for the element that is out of the [0, numBuckets) range.
 */

void *HashSetLookup(hashset *h, const void *elemAddr);

/**
 * Function: HashSetMap
 * --------------------
 * Iterates over all of the stored elements, applying the specified
 * mapfn to the addresses of each.  The auxData parameter can be
 * used to propagate additional data to each of the mapfn calls; in
 * fact, the auxData value is passed in as the second argument to
 * each mapfn application.  It is the responsibility of the mapping
 * function to received that auxData and handle it accordingly.  NULL
 * should be passed in as the auxData if (and only if) the mapping
 * function itself ignores its second parameter.
 *
 * An assert is raised if the mapping routine is NULL.
 */

void HashSetMap(hashset *h, HashSetMapFunction mapfn, void *auxData);
     
#endif
