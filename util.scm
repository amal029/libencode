(declare (unit util))

;;; parition by index function
(define (parition-indexed f l)
  (letrec ((part (lambda (count fi se)
		   (if (null? l)
		       (values fi se)
		       (cond
			((f (car l) count)
			 (part (+ count 1)
			       (cons (car l) fi) se))
			(else
			 (part (+ count 1) fi
			       (cons (car l) se))))))))
    (part '() '() 0)))
