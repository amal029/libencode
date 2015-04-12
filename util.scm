;(declare (unit util))

;;; parition by index function
(define (partition-indexed f l)
  (letrec ((part (lambda (fi se count ll)
		   (if (null? ll)
		       (values fi se)
		       (cond
			((f (car ll) count)
			 (part (cons (car ll) fi) se
			       (+ count 1)
			       (cdr ll)))
			(else
			 (part fi (cons (car ll) se)
			       (+ count 1)
			       (cdr ll))))))))
    (part '() '() 0 l)))

#;
(define (alist? al)
  (and (list? al) (not (null? al)) (every pair? al)))
