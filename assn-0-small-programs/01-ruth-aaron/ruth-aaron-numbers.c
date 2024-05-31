#include <stdio.h>
#include <stdlib.h>
#include <math.h>

/**
 * Type: bool
 * ----------
 * Pure C doesn't have a true bool type, so we emulate
 * the bool by defining an enumerated type with two
 * values: false (equated with 0), and true (equated with 1).
 * Old school C programmers don't even use bools; they just
 * use 0 and 1.  But bools are nice so we introduce them here.
 */

typedef enum {
  false = 0, true
} bool;

/**
 * Helpers functions... (the static keyword meands they
 * can only be called from within this file.)
 */

static bool isRuthAaronNumber(int n);
static int sumOfPrimeFactors(int n);
static bool isPrime(int n);

/**
 * Defines the entry point of the program.  The program
 * lists the first 25 Ruth-Aaron pairs, which are integer
 * pairs of the form (n, n + 1), where the prime factorization
 * sum of n and n + 1 are exactly the same.
 *
 * @param argc the number of tokens making up the command line
 *        used to invoke the program. (unused)
 * @param argv the actual tokens, expressed as an array of C strings.
 * @return always zero, to express that the application (in this case)
 *         always succeeds.  More sophisticated applications might
 *         return non-zero values to communicate to the operating
 *         system that something went wrong.
 */

int main(int argc, char **argv)
{
  printf("This program lists out the first 25 Ruth-Aaron number pairs.\n");
  printf("Here they are:\n");
  printf("-------------\n");
  
  int numFound = 0;
  int numToConsider = 1;
  while (numFound < 25) {
    if (isRuthAaronNumber(numToConsider)) {
      numFound++;
      printf("  %2d.) %d and %d\n", numFound, numToConsider, numToConsider + 1);
    }
    numToConsider++;
  }
  
  return 0;
}

/**
 * Determines whether the specified integer n is a Ruth-Aaron
 * numbers--that is, that (n, n + 1) is a Ruth-Aaron pair.
 *
 * @param n an integer (presumably positive)
 * @return true if and only if (n, n + 1) is a Ruth-Aaron
 *         pair.
 */

static bool isRuthAaronNumber(int n)
{
  return sumOfPrimeFactors(n) == sumOfPrimeFactors(n + 1);
}

/**
 * Computes the sum of primes making up the prime
 * factorization of the specified integer.
 *
 * @param n an integer (presumably positive)
 * @return the sum of all of the primes in the prime
 *         factorization.
 *
 * Examples: sumOfPrimeFactors(8) returns 6 (because 2 + 2 + 2 == 6)
 *           sumOfPrimeFactors(75) returns 13 (because 3 + 5 + 5 == 75)
 *           sumOfPrimeFactors(17) returns 17 (because 17 is its own 
 *                                             prime factorization)
 *           sumOfPrimeFactors(120) returns 14 (because 2 + 2 + 2 + 3 + 5 == 14)
 *           sumOfPrimeFactors(2) returns 2 (because 2 is its own
 *                                           prime factorization)
 *           sumOfPrimeFactors(1) returns 0 (trick! the prime factorization
 *                                           of 1 is the empty product)
 */

static int sumOfPrimeFactors(int n)
{
  int sum = 0;
  int divisor = 2;
  
  while (n > 1) {
    if (isPrime(divisor) && (n % divisor == 0)) {
      sum += divisor;
      n /= divisor;
    } else {
      divisor++;
    }
  }

  return sum;
}

/**
 * Returns true if and only if the specified 
 * integer is prime.  A number is prime if and
 * only if it's positive and it has exactly two
 * distinct divisors.
 *
 * @param n the number being tested for primality.
 * @return true if and only if the specified param is prime.
 */

static bool isPrime(int n)
{
  if (n <= 1) return false;
  if (n == 2) return true;
  
  int divisor;
  for (divisor = 2; divisor <= sqrt(n); divisor++) {
    if (n % divisor == 0)
      return false;
  }

  return true;
}
