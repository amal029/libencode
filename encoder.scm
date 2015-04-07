(define (int->bint sexp)
  (if (number? sexp)
      (let ((x (string-append "i" (number->string sexp) "e")))
	x)
      (error "Not a number: " sexp)))

(define (string->bstring sexp)
  (if (string? sexp)
      (string-append (number->string (string-length sexp)) ":" sexp)
      (error "Not a string: " sexp)))

(define (list->blist sexp)
  (if (list? sexp)
      (let* ((x (map encode sexp))
	     (y (foldl string-append "" x))
	     (z (string-append "l" y "e")))
	z)
      (error "Not a list: " sexp)))

(define (alist->bdict sexp)
  (if (alist? sexp)
      (let* ((l (fold cons* '()
		      (reverse (map car sexp))
		      (reverse (map cdr sexp))))
	     (x (map encode l))
	     (y (foldl string-append "" x))
	     (z (string-append "d" y "e")))
	z)
      (error "Not a alist: " sexp)))


(define (encode sexp)
  (cond
    ((number? sexp) (int->bint sexp))
    ((string? sexp) (string->bstring sexp))
    ;; Every list is also an alist,
    ;; so alist needs to be checked
    ;; before list
    ((alist? sexp)  (alist->bdict sexp))
    ((list? sexp)   (list->blist sexp))
    (else (error "Don't know how to encode" sexp))))
