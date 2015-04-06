(declare
  (hide build-string-type)
  (hide build-int-type)
  (hide build-list-type)
  (hide build-dict-type)
  (unit decoder) (uses extras)
  (uses util))



;;; Stops reading after the specified number of characters
(define (build-string-type iport chars)
  (letrec ((build (lambda (res count)
		    (let ((c (read-char iport)))
		      (if (<= count (+ 1 chars))
			  (cond
			   ((eof-object? c)
			    (error "Malformed Bencode string:" res))
			   ((equal? count 0)
			    (build res (+ 1 count)))
			   (else
			    (build (cons c res) (+ 1 count))))
			  (list->string res))))))
    (build '() 0)))

;;; Uses the delimeter #\e to stop reading
(define (build-int-type iport)
  (letrec ((build (lambda (res)
		    (let ((c (read-char iport)))
		      (cond
		       ((eof-object? c)
			(error "Malformed Bencode integer: " res))
		       ((equal? #\e c)
			(string->number (list->string res)))
		       (else (build (cons c res))))))))
    (build '())))

;;; Uses the delimeter #\e to stop reading
(define (build-list-type iport)
  (letrec ((build (lambda (res)
		    (let ((c (read-char iport)))
		      (cond
		       ((eof-object? c)
			(error "Malformed Bencode list: " res))
		       ((equal? #\e c) res)
		       (else
			(build (cons (decoder iport) res))))))))
    (build '())))

(define (build-dict-type iport)
  (let ((ll (build-list-type iport)))
    (let-values (((k v) (partition-indexed
			 (lambda (_ i) (equal? (modulo i 2) 0)) ll)))
      (zip k v))))

(define (decoder iport)
  (let ((c (read-char iport)))
    (cond
     ((eof-object? c)
      (error "Malformed Bencode: " c))
     (else
      (cond
       ((equal? #\i c) (build-int-type  iport))
       ((equal? #\l c) (build-list-type iport))
       ((equal? #\d c) (build-dict-type iport))
       ((char-numeric? c) (build-string-type
			   iport (char->integer c))))))))
