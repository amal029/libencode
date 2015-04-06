(declare (uses util) (uses decoder))

;;; Test-1: test positive integer bencode
(let ((iport (open-input-string "i4e")))
  (assert (equal? 4 (decoder iport))
	  "INT TEST FAIL: i4e")
  (close-input-port iport))

;;; Test-2 Large integer number
(let ((iport (open-input-string "i4000e")))
  (assert (equal? 4000 (decoder iport))
	  "BIG INTEGER TEST FAIL: i4000e")
  (close-input-port iport))

;;; Test-3: test negative integer bencode
(let ((iport (open-input-string "i-4e")))
  (assert (equal? -4 (decoder iport))
	  "NEGATIVE INT TEST FAIL: i-4e")
  (close-input-port iport))

;;; Test-4 string test
(let ((iport (open-input-string "4:spam")))
  (assert (equal? "spam" (decoder iport))
	  "STRING TEST FAIL: 4:spam")
  (close-input-port iport))

;;; Test-5 string test
(let ((iport (open-input-string "12:avinashmalik")))
  (assert (equal? "avinashmalik" (decoder iport))
	  "STRING TEST FAIL: 12:avinashmalik")
  (close-input-port iport))

;;; Test-6 list test
(let ((iport (open-input-string "l4:spame")))
  (assert (equal?  '("spam") (decoder iport))
	  "LIST TEST FAIL: l4:spame")
  (close-input-port iport))

;;; Test-7 list test
(let ((iport (open-input-string "l4:spam4:eggse")))
  (assert (equal?  '("spam" "eggs") (decoder iport))
	  "LIST TEST FAIL: l4:spam4:eggse")
  (close-input-port iport))

;;; Test-8 list test
(let ((iport (open-input-string "l4:spam4:eggsi4ee")))
  (assert (equal?  '("spam" "eggs" 4) (decoder iport))
	  "LIST TEST FAIL: l4:spam4:eggsi4ee")
  (close-input-port iport))

;;; Test-9 dict test
(let ((iport (open-input-string "d3:cow3:moo4:spam4:eggse")))
  (assert (equal?  '(("cow" "moo") ("spam" "eggs"))
		   (decoder iport))
	  "DICT TEST FAIL: d3:cow3:moo4:spam4:eggse")
  (close-input-port iport))

;;; Test-10 complex dict test
(let ((iport (open-input-string "d4:spaml1:a1:bee")))
  (assert (equal?  '(("spam" ("a" "b")))
		   (decoder iport))
	  "DICT TEST FAIL: d4:spaml1:a1:bee")
  (close-input-port iport))
