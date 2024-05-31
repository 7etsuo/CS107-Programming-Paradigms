;;
;; Function: celsius->fahrenheit
;; -----------------------------
;; Simple conversion function to bring a Celsius
;; degree amount into Fahrenheit.  
;;

(define (celsius->fahrenheit celsius)
  (+ (* 1.8 celsius) 32))

;;
;; Predicate function: leap-year?
;; ------------------------------
;; Illustrates the use of the 'or, 'and, and 'not
;; special forms.  The question mark after the
;; function name isn't required, it's just customary
;; to include a question mark at the end of a
;; function that returns a true or false (as #t or #f)
;; incidentally)
;;

(define (leap-year? year)
  (or (and (zero? (remainder year 4))
	   (not (zero? (remainder year 100))))
      (zero? (remainder year 400))))

;;
;; Function: factorial
;; -------------------
;; Traditional recursive formulation of the most obvious
;; function ever.  Note the use of the built-in zero? predicate
;; to check to see whether or not we have a base case.
;;
;; What's most impressive about this function is that it demonstrates
;; how Scheme can represent arbitrarily large integers.  Type
;; in (factorial 1000) and see what you get.  Try doing that with
;; C or Java.
;;

(define (factorial n)
  (if (zero? n) 1
      (* n (factorial (- n 1)))))

;;
;; Function: fibonacci
;; -------------------
;; Traditional recursive implementation of
;; the fibonacci function.  This particular
;; implementation is quite inefficient, since
;; it makes an exponential number of recursive
;; calls.
;;

(define (fibonacci n)
  (if (< n 2) n
      (+ (fibonacci (- n 1))
	 (fibonacci (- n 2)))))

;;
;; Function: fast-fibonacci
;; ------------------------
;; Relies on the services of a locally defined function to
;; generate the nth fibonacci much more quickly.  The
;; key observation here is that the nth number is the Fibonacci
;; sequence starting out 0, 1, 1, 2, 3, 5, 8 is the n-1th 
;; number in the Fibonacci-like sequence starting out with
;; 1, 1, 2, 3, 5, 8.  The recursion basically slides down
;; the sequence n or so times in order to compute the answer.
;; As a result, the recursion is linear and not binary, and it
;; runs as quickly as factorial does.
;;
;; Note that fast-fibonacci is a globally defined function,
;; but the fast-fibonacci-helper function exists only as long
;; as the funtion call itself.
;;

(define (fast-fibonacci n)
  (define (fast-fibonacci-helper n base-0 base-1)
    (cond ((zero? n) base-0)
	  ((zero? (- n 1)) base-1)
	  (else (fast-fibonacci-helper (- n 1) base-1 (+ base-0 base-1)))))
  (fast-fibonacci-helper n 0 1))

;;
;; Function: sum
;; -------------
;; Accepts the number list and generates the sum of all the
;; numbers in that list.
;;

(define (sum ls)
  (if (null? ls) 0
      (+ (car ls) (sum (cdr ls)))))

;;
;; Function: dot-product
;; ---------------------
;; Assumes the two lists one and two really represent
;; mathematical vectors, and computes the dot product.
;;

(define (dot-product one two)
  (if (null? one) 0
      (+ (* (car one) (car two))
	 (dot-product (cdr one) (cdr two)))))

;;
;; Function: triple-everything
;; ---------------------------
;; Takes a list of integers (identified by sequence)
;; and generates a copy of the list, except that
;; every integer in the new list has been tripled.
;;

(define (triple-everything numbers)
  (if (null? numbers) '()
      (cons (* 3 (car numbers)) (triple-everything (cdr numbers)))))

;;
;; Function: generate-partial-concatenations
;; -----------------------------------------
;; Takes a list of strings and generates a new list of the
;; same length, where the nth element of the new list is
;; the running concatenation of the the original list's first
;; n elements.
;;
;; It takes '("a" "b" "c") and creates ("a" "ab" "acb").
;; It takes '("CS" "107" "L") and makes ("CS" "CS107" "CS107L").
;;
;; This particular implementation relies on a helper function,
;; just like fast-fibonacci does.  The helper procedure not
;; only tracks what portion of the list remains to be seen, but
;; the accumulation of all strings seen so far as well.
;;

(define (generate-concatenations strings)
  (generate-concatenations-using strings ""))

(define (generate-concatenations-using strings accumulation)
  (if (null? strings) '()
      (cons (string-append accumulation (car strings))
	    (generate-concatenations-using (cdr strings)
					   (string-append accumulation (car strings))))))

;;
;; Function: power
;; ---------------
;; Assumes that exponent is a non-negative integer.  This
;; particular implemnentation is the realization of the following
;; inductive definition (all divisions are integer divisions)
;;
;;     n^m = 1                if m is 0
;;         = (n^(m/2))^2      if m is even
;;         = n * (n^(m/2))^2  if m is odd

(define (power base exponent)
  (cond ((zero? exponent) 1)
	((zero? (remainder exponent 2)) (* (power base (quotient exponent 2))
					   (power base (quotient exponent 2))))
	(else (* base 
		 (power base (quotient exponent 2))
		 (power base (quotient exponent 2))))))

;;
;; Function: pwr
;; -------------
;; Functionally identical to the implementation of power, except
;; that pwr uses a let expression to bind a local symbol called root
;; to the result of the recursive call.
;;

(define (pwr base exponent)
  (if (zero? exponent) 1
      (let ((root (pwr base (quotient exponent 2))))
	(if (zero? (remainder exponent 2))
	    (* root root)
	    (* root root base)))))

;;
;; Function: flatten
;; -----------------
;; Takes an arbitrary list and generates a another list where all atoms of the
;; original are laid down in order as top level elements.
;; 
;; In order for the entire list to be flattened, the cdr of the
;; list needs to be flattened.  If the car of the entire list is a primitive
;; (number, string, character, whatever), then all we need to do is
;; cons that primitive onto the front of the recursively flattened cdr.
;; If the car is itself a list, then it also needs to be flattened. 
;; The flattened cdr then gets appended to the flattened car.
;;

(define (flatten sequence)
  (cond ((null? sequence) '())
	((list? (car sequence)) (append (flatten (car sequence)) (flatten (cdr sequence))))
	(else (cons (car sequence) (flatten (cdr sequence))))))

;;
;; Function: filter
;; ----------------
;; Generated an independent copy of the original list, where
;; each element is retained if and only if it passes the specified
;; predicate.
;;

(define (filter sequence pred)
  (if ((null? sequence) '())
      (let ((filter-of-rest (filter (cdr sequence) pred)))
	(if (pred (car sequence))
	    (cons (car sequence) filter-of-rest)
	    filter-of-rest))))

;;
;; Function: partition
;; -------------------
;; Takes a pivot and a list and produces a pair two lists.
;; The first of the two lists contains all of those element less than the 
;; pivot, and the second contains everything else.  Notice that
;; the first list pair every produced is (() ()), and as the
;; recursion unwinds exactly one of the two lists gets a new element
;; cons'ed to the front of it.  
;; 

(define (partition pivot num-list)
  (if (null? num-list) '(() ())
      (let ((split-of-rest (partition pivot (cdr num-list))))
	(if (< (car num-list) pivot)
	    (list (cons (car num-list) (car split-of-rest)) (cadr split-of-rest))
	    (list (car split-of-rest) (cons (car num-list) (car (cdr split-of-rest))))))))

;;
;; Function: quicksort
;; -------------------
;; Implements the quicksort algorithm to sort lists of numbers from
;; high to low.  If a list is of length 0 or 1, then it is trivially
;; sorted.  Otherwise, we partition to cdr of the list around the car
;; to generate two lists: those in the cdr that are smaller than the car,
;; and those in the cdr that are greater than or equal to the car.  
;; We then recursively quicksort the two lists, and then splice everything
;; together in the proper order.
;;

(define (quicksort num-list)
  (if (<= (length num-list) 1) num-list
      (let ((split (partition (car num-list) (cdr num-list))))
	(append (quicksort (car split)) 
		(list (car num-list)) 
		(quicksort (cadr split))))))

;;
;; Function: sorted?
;; -----------------
;; Returns true if and only if the specified list is sorted
;; according to the specified predicate function.  In other words,
;; true is returned if and only if each neighboring pair respects
;; the specified comparison function.
;;

(define (sorted? sequence comp)
  (or (< (length sequence) 2)
      (and (comp (car sequence) (car (cdr sequence)))
	   (sorted? (cdr sequence) comp))))

;;
;; Function: merge
;; ---------------
;; Takes the two lists, each of which is assumed to be sorted
;; according to the specified comparator function, and synthesizes
;; an fresh list which is the sorted merge of the incoming two.
;; 
;; If one of the lists is empty, then merge can just return the
;; other one.  If not, then the specified comp is used to determine
;; which of the two cars deserves to be at the front.  Recursion (what else?)
;; is then used to generate the merge of everything else, and the winning
;; car is cons to the front of it.
;;

(define (merge list1 list2 comp)
  (cond ((null? list1) list2)
	((null? list2) list1)
	((comp (car list1) (car list2)) (cons (car list1) (merge (cdr list1) list2 comp)))
	(else (cons (car list2) (merge list1 (cdr list2) comp)))))

;; 
;; Function: prefix-of-list
;; ------------------------
;; Accepts a list and returns a new list with just the
;; first k elements.  If k is greater than the original
;; list length, the entire list is replicated.  If k is
;; negative, then don't except it to work. :)
;;

(define (prefix-of-list ls k)
  (if (or (zero? k) (null? ls)) '()
      (cons (car ls) (prefix-of-list (cdr ls) (- k 1)))))

;;
;; Function: mergesort
;; -------------------
;; Sorts the incoming list called ls so that all neighboring
;; pairs of the final list respect the specified comparator function.
;; 
;; mergesort works by taking the unsorted list, generating copies of
;; the front half and the back half, recursively sorting them, and then
;; merging the two sorted half lists.  That's classic mergesort.
;; The reverse call is a bit hokey, but it brings the back half to
;; the front so that our prefix-of-list function has access to the
;; back-end elements.  The fact that the elements are in the reverse
;; of the original order is immaterial, since we don't care about
;; the original order.
;;

(define (mergesort ls comp)
  (if (<= (length ls) 1) ls
      (let ((front-length (quotient (length ls) 2))
	    (back-length (- (length ls) (quotient (length ls) 2))))
	(merge (mergesort (prefix-of-list ls front-length) comp)
	       (mergesort (prefix-of-list (reverse ls) back-length) comp)
	       comp))))

;;
;; Function: distance-from-origin
;; ------------------------------
;; Returns the Euclidean distance of the specified 
;; two-dimensional point (expressed as a list of
;; two numbers) from the origin.  Classic Pythagorean theorem.
;;

(define (distance-from-origin pt)
  (sqrt (+ (* (car pt) (car pt))
	   (* (cadr pt) (cadr pt)))))

;;
;; Function: distance-from-origin<?
;; --------------------------------
;; Returns true if and only if the first point
;; is strictly closer to the origin that the second
;; one.
;; 

(define (distance-from-origin<? pt1 pt2)
  (< (distance-from-origin pt1)
     (distance-from-origin pt2)))

;;
;; Function: unary-map
;; -------------------
;; We pretend that the map function doesn't exist, and we write
;; our own.  As you can see, it isn't all that difficult to get
;; a unary version of map working.
;;

(define (unary-map fn seq)
  (if (null? seq) '()
      (cons (fn (car seq)) (unary-map fn (cdr seq)))))

;;
;; Function: average
;; -----------------
;; Quick, clean way to compute the average of a list of numbers
;; without using car-cdr recursion.  This is the canonical example
;; on why apply belongs in a functional language.
;;

(define (average num-list)
  (/ (apply + num-list) (length num-list)))

;;
;; Function: depth
;; ---------------
;; Computes the depth of a list, where depth is understood
;; to be the largest number of open left parentheses to the left
;; of some primitive.  We assume that () doesn't appear anywhere
;; in the overall list.
;;

(define (depth tree)
  (if (or (not (list? tree)) (null? tree)) 0
      (+ 1 (apply max (map depth tree)))))

;;
;; Function: flatten-list
;; ----------------------
;; Flattens a list just like the original flatten does, but
;; it uses map, apply, and append instead of car-cdr recursion.
;;

(define (flatten-list ls)
  (cond ((null? ls) '())
	((not (list? ls)) (list ls))
	(else (apply append (map flatten-list ls)))))

;;
;; Function: translate
;; -------------------
;; Takes the specified list and the specified delta and generates
;; a new list where every element of the original is shifted by the
;; specified delta.
;;

(define (translate numbers delta)
  (define (shift number)
    (+ number delta))
  (map shift numbers))

;;
;; Function: translate
;; -------------------
;; Takes the specified list and the specified delta and generates
;; a new list where every element of the original is shifted by the
;; specified delta.  This version uses the lambda construct
;; to define a nameless function in place.
;;

(define (translate numbers delta)
  (map (lambda (number) (+ number delta)) numbers))

;;
;; Function: power-set
;; ------------------
;; The powerset of a set is the set of all its subsets.
;; The key recursive breakdown is:
;;
;;       The powerset of {} is {{}}.  That's because the empty 
;;           set is a subset of itself.
;;       The powerset of a non-empty set A with first element a is
;;           equal to the concatenation of two sets:
;;              - the first set is the powerset of A - {a}.  This
;;                recursively gives us all those subsets of A that
;;                exclude a.
;;              - the second set is once again the powerset of A - {a},
;;                except that a has been prepended aka consed to the
;;                front of every subset.
;;

(define (power-set set)
  (if (null? set) '(())
      (let ((power-set-of-rest (power-set (cdr set))))
	(append power-set-of-rest
		(map (lambda (subset) (cons (car set) subset)) 
		     power-set-of-rest)))))

;;
;; Function: k-subsets
;; -------------------
;; Another combinatorics problem, and this one is more difficult
;; than powerset.  k-subsets basically constructs the set of all
;; subsets of a specific size.
;; 
;; Generates the set of all k-subsets of the cdr, and then
;; appends to that the set of all k-1-subsets of the cdr, with the
;; car prepended to each and every one of them.
;;

(define (k-subsets set k)
  (cond ((eq? (length set) k) (list set))
	((zero? k) '(()))
	((or (negative? k) (> k (length set))) '())
	(else (let ((k-subsets-of-rest (k-subsets (cdr set) k))
		    (k-1-subsets-of-rest (k-subsets (cdr set) (- k 1))))
		(append (map (lambda (subset) (cons (car set) subset)) k-1-subsets-of-rest)
			k-subsets-of-rest)))))

;;
;; Function: is-up-down?
;; ---------------------
;; Returns true if and only if the specified sequence
;; is up-down, where the definition of up is dictated by
;; the implementation of comp.  All sequences of length
;; 0 and 1 are trivially considered to the up-down, since
;; it's impossible for it to have any violations.
;; Otherwise, we confirm that the car and the cadr respect
;; the specified predicate, and then confirm that the cdr 
;; respects the invertion of the predicate.
;;
;; Note that the lambda switches the two roles of own and two.
;; Clever, but the drawback is that lambdas layer over lambdas
;; layer over lambdas for long sequences.
;; 

(define (is-up-down? ls comp)
  (or (null? ls)
      (null? (cdr ls))
      (and (comp (car ls) (cadr ls))
	   (is-up-down? (cdr ls) (lambda (one two) (comp two one))))))

;;
;; Function: up-down?
;; ------------------
;; Same is is-up-down?, save for the fact that
;; we recur on the cddr instead of the cdr, do more
;; base case checking, all so we can avoid the layering of
;; the lambdas.
;;

(define (up-down? ls comp)
  (or (null? ls)
      (null? (cdr ls))
      (and (comp (car ls) (cadr ls))
	   (or (null? (cddr ls))
	       (and (comp (caddr ls) (cadr ls))
		    (up-down? (cddr ls) comp))))))

(define (construct-permutation-generator comp inverted-permute ls)
  (lambda (number)
    (apply append
	   (map (lambda (permutation)
		  (if (comp number (car permutation))
		      (list (cons number permutation))
		      '())) 
		(inverted-permute (remove ls number))))))

(define (up-down-permute ls)
  (if (<= (length ls) 1) (list ls)
      (apply append (map (construct-permutation-generator < down-up-permute ls) ls))))

(define (down-up-permute ls)
  (if (<= (length ls) 1) (list ls)
      (apply append (map (construct-permutation-generator > up-down-permute ls) ls))))

;;
;; Function: remove
;; ----------------
;; Generates a copy of the incoming list, except that
;; all elements that match the specified element in the equal?
;; sense are excluded.
;;

(define (remove ls elem)
  (cond ((null? ls) '())
	((equal? (car ls) elem) (remove (cdr ls) elem))
	(else (cons (car ls) (remove (cdr ls) elem)))))

;;
;; Function: permutations
;; ----------------------
;; Generates all of the permutations of the specified list, operating
;; on the understanding that each of the n elements appears as the first
;; element of 1/n of the permutations.  The best approach uses mapping
;; to generate n different sets, where each of these sets are those
;; permutations with the nth element at the front.  We use map to transform
;; each element x into the subset of permutations that have x at the
;; front.  The mapping function that DOES that transformation is itself
;; a call to map, which manages to map an anonymous consing routine
;; over all of the permutations of the list without x.  This is
;; as dense as it gets.
;;

(define (permutations items)
  (if (null? items) '(())
      (apply append
	     (map (lambda (element)
		    (map (lambda (permutation)
			   (cons element permutation))
			 (permutations (remove items element))))
		  items))))

;;
;; Function: construct-permutation-prepender
;; ----------------------------------------
;; Evaluates to a function that takes an arbitrary
;; list (presumably a permutation) and conses the
;; incoming element to the front of it.  
;;
;; Notice that the implementation of the constructed
;; function is framed in terms of whatever data
;; happens to be attached to the incoming element.
;;

(define (construct-permutation-prepender element)
  (lambda (permutation)
    (cons element permutation)))

;;
;; Function: construct-permutations-generator 
;; ------------------------------------------
;; Evaluates to a function (yes, a function) on one argument 
;; (called element) that knows how to generate all of the permutations of the
;; specified list (called items) such that the supplied element
;; argument is at the front.
;;

(define (construct-permutations-generator items)
  (lambda (element)
    (map (construct-permutation-prepender element) (all-permutations (remove items element)))))

;;
;; Function: all-permutations
;; --------------------------
;; Generates all of the permutations of the specified
;; list called items.  Algorithmically identical to
;; the permutations function written above.
;;

(define (all-permutations items)
  (if (null? items) '(())
      (apply append
	     (map (construct-permutations-generator items) items))))

;;
;; Function: generic-map
;; ---------------------
;; Relies on the services of the unary-map function to 
;; gather the cars of all the lists to be fed the supplied
;; fn, and then gathers all of the cdrs for the recursive call.
;;

(define (generic-map fn primary-list . other-lists)
  (if (null? primary-list) '()
      (cons (apply fn (cons (car primary-list) (unary-map car other-lists)))
	    (apply generic-map (cons fn (cons (cdr primary-list) (unary-map cdr other-lists)))))))
