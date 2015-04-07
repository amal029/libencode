(require-extension libencode)

;;; DECODING TESTS

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

;;; Test-6.1 list test
(let ((iport (open-input-string "le")))
  (assert (equal?  '() (decoder iport))
	  "LIST TEST FAIL: le")
  (close-input-port iport))

;;; Test-6.2 list test
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
  (assert (equal?  '(("cow" . "moo") ("spam" . "eggs"))
		   (decoder iport))
	  "DICT TEST FAIL: d3:cow3:moo4:spam4:eggse")
  (close-input-port iport))

;;; Test-10 dict test
(let ((iport (open-input-string "d4:spaml1:a1:bee")))
  (assert (equal?  '(("spam" . ("a" "b")))
		   (decoder iport))
	  "DICT TEST FAIL: d4:spaml1:a1:bee")
  (close-input-port iport))

;;; Test-11 dict test
(let ((iport (open-input-string "d4:spaml1:a1:bei-1eli500eee")))
  (assert (equal?  '(("spam" . ("a" "b"))
		     (-1 . (500)))
		   (decoder iport))
	  "DICT TEST FAIL: d4:spaml1:a1:bei-1eli500eee")
  (close-input-port iport))

;;; ENCODING TESTS

;;; Test-1: test positive integer bencode
(let ()
  (assert (equal? "i4e" (encode 4))
	  "INT TEST FAIL: i4e"))

;;; Test-2 Large integer number
(let ()
  (assert (equal? "i4000e" (encode 4000))
	  "BIG INTEGER TEST FAIL: i4000e"))

;;; Test-3: test negative integer bencode
(let ()
  (assert (equal? "i-4e" (encode -4))
	  "INT TEST FAIL: i-4e"))

;;; Test-4 string test
(let ()
  (assert (equal? "4:spam" (encode "spam"))
	  "STRING TEST FAIL: 4:spam"))

;;; Test-5 string test
(let ()
  (assert (equal? "12:avinashmalik" (encode "avinashmalik"))
	  "STRING TEST FAIL: 12:avinashmalik"))

;;; Test-6.1 list test
(let ()
  (assert (equal?  "le" (encode '()))
	  "LIST TEST FAIL: le"))

;;; Test-6.2 list test
(let ()
  (assert (equal?  "l4:spame" (encode '("spam")))
	  "LIST TEST FAIL: l4:spame"))

;;; Test-11 dict test
(let ()
  (assert (equal?
	   "d4:spaml1:a1:bei-1eli500eee"
	   (encode '(("spam" . ("a" "b"))
		     (-1 . (500)))))
	  "DICT TEST FAIL: d4:spaml1:a1:bei-1eli500eee"))
