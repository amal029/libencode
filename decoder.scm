(require-extension srfi-1)

;;; Stops reading after the specified number of characters
(define (build-string-type iport chars)
  (letrec ((build (lambda (res count)
		    (if (< count chars)
			(let ((c (read-char iport)))
			  (cond
			   ((eof-object? c)
			    (error "Malformed Bencode string: "
				   (reverse res)))
			   (else
			    (build (cons c res) (+ 1 count)))))
			(begin
			  (list->string (reverse res)))))))
    (build '() 0)))

;;; Uses the delimeter delim to stop reading
(define (build-int-type fc iport delim)
  (letrec ((build (lambda (res)
		    (let ((c (read-char iport)))
		      (cond
		       ((eof-object? c)
			(error "Malformed Bencode integer: " res))
		       ((equal? delim c)
			(string->number (list->string
					 (reverse res))))
		       (else (build (cons c res))))))))
    (if (null? fc) (build '())
	(build (cons fc '())))))

;;; Uses the delimeter #\e to stop reading
(define (build-list-type iport)
  (letrec ((build (lambda (res)
		    (let ((c (peek-char iport)))
		      (cond
		       ((eof-object? c)
			(let ((_ (read-char iport)))
			  (error "Malformed Bencode list: "
				 (reverse res))))
		       ((equal? #\e c)
			(let ((_ (read-char iport)))
			  (reverse res)))
		       (else (build
			      (cons (decoder iport) res))))))))
    (build '())))

(define (build-dict-type iport)
  (let ((ll (build-list-type iport)))
    (let-values (((k v) (partition-indexed
			 (lambda (_ i)
			   (equal? (modulo i 2) 0)) ll)))
      (fold alist-cons '() k v))))

(define (decoder iport)
  @("Decode Bencode format to an s-expression"
    (iport "The input port to read from")
    @to "s-expression"
    @example "Converting the bencoded value into s-expression"
    (let ((iport (open-input-string "d4:spaml1:a1:bei-1eli500eee")))
      (assert (equal?  '(("spam" . ("a" "b"))
			 (-1 . (500)))
		       (decoder iport))
	      "DICT TEST FAIL: d4:spaml1:a1:bei-1eli500eee")
      (close-input-port iport)))
  (let ((c (read-char iport)))
    (cond
     ((eof-object? c)
      (error "Malformed Bencode: " c))
     (else
      (cond
       ((equal? #\i c) (build-int-type '() iport #\e))
       ((equal? #\l c) (build-list-type iport))
       ((equal? #\d c) (build-dict-type iport))
       ((char-numeric? c) (build-string-type
			   iport (build-int-type
				  c iport #\:))))))))
