(declare (unit util))

;;; parition by index function
(define (parition-indexed f l)
  (letrec ((part (lambda (count fi se ll)
		   (if (null? ll)
		       (values fi se)
		       (cond
			((f (car ll) count)
			 (part (+ count 1)
			       (cons (car l) fi) se
			       (cdr ll)))
			(else
			 (part (+ count 1) fi
			       (cons (car l) se)
			       (cdr ll))))))))
    (part '() '() 0 l)))
