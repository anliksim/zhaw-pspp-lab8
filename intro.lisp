#!/usr/local/bin/sbcl --script

;;; experimental stuff

;; print hello world
(write-line "Hello, World!")

;; function that takes a string and evaluates it as expression
(defun pexec-string (expr) "Prints command and execution result."
  (format t "~S -> ~S~%" expr (eval (read-from-string expr))))

(pexec-string "(+ 1 2)")


;; macro that prints an expression and it's evaluation
(defmacro pex (expr)
  (let ((tmp (gensym "tmp")))
    `(let ((,tmp ,expr))
       (format t "~S evaluates to ~S~%" ',expr ,tmp)
       ,tmp)))

(pex (+ 1 2))
(terpri)

;;;; 1

(write-line "1")

;;; a)

(write-line "a)")
(pex (- (* 10 (+ 4 3 3 1)) 20))
(pex 42)
(pex pi)
(pex (/ 4 3))
(pex (/ 12 3))
(pex (/ 4 3.0))
(pex (+ 0.5 1/2))
(pex (* 35 1.16))
(pex (sqrt 2))
(pex (expt 12 32))
(pex (floor (/ 5 2)))
(pex (zerop 25))
(pex (zerop 0))

;;; b)

(write-line "b)")
(pex 'zitrone)
(pex (quote zitrone))
(pex (list 'apfel 'banane 'zitrone))
(pex '(apfel banane zitrone))
(pex (car '(apfel banane zitrone)))
(pex (cdr '(apfel banane zitrone)))
(pex (caaddr '((apfel banane) zitrone (dattel erdbeere))))
(pex (length '((apfel banane) zitrone (dattel erdbeere))))
(pex (append '(apfhel banane zitrone) '(dattel erdbeere)))
(pex (cons 'zitrone '(apfel banane)))
(pex (reverse '(apfel banane zitrone)))

;;; c)

(write-line "c)")
(pex (car (cdr (car (cdr (car '((w (x y)))))))))
(pex (car (cdr '((w u) y z))))
(pex (car (cdr (cdr (car '((w (x) y) u))))))
(pex (car (car (car (car '((((y))) w))))))

(terpri)

;;;; 2 / 3

(write-line "2 / 3")


(defun list-double (list) "Doubles all values in the list."
  (mapcar #'(lambda (x) (* 2 x)) list))

(pex (list-double '(1 2 3 4)))
(pex (cons 9 '(a b c d)))

(defun eval-sign (x) "Evaluates the sign of a number."
  (if (= 0 x) 0
    (if (> x 0) 1
      -1)))

(defun list-sign (list) "Creates a list of signs from the input list."
  (mapcar #'eval-sign list))

(defun list-sign-rec (list) "Creates a list of signs from the input list not using lambdas."
  (if (null list) nil
    (cons (eval-sign (car list)) (list-sign-rec (cdr list)))))

(pex (list-sign '(5 2 -3 -1 0 3 -2)))
(pex (list-sign-rec '(5 2 -3 -1 0 3 -2)))

(terpri)

;;;; 4

(write-line "4")

(defun list-sum (list) "Sums elements of a list."
  (reduce #'+ list))

(defun list-sum-rec (list) "Sums elements of a list not using reduce."
  (if (null list) 0
    (+ (car list) (list-sum-rec (cdr list)))))

(pex (list-sum '(10 20 7)))
(pex (list-sum-rec '(10 20 7)))


(defun list-mult (list) "Multiplies elements of a list."
  (reduce #'* list))

(defun list-mult-rec (list) "Multiplies elements of a list not using reduce."
  (if (null list) 1
    (* (car list) (list-mult-rec (cdr list)))))

(pex (list-mult '(10 20 7)))
(pex (list-mult-rec '(10 20 7)))


(defun all-true (list) "Checks if all values in a list are true."
  (reduce #'(lambda (x y) (and x y)) list :initial-value T))

(defun all-true-rec (list) "Checks if all values in a list are true not using reduce."
  (if (null list) T
    (and (car list) (all-true-rec (cdr list)))))


(pex (all-true '()))
(pex (all-true '(34 hallo (7)))) ; does not resolve sublist - bad luck :o)
(pex (all-true '(34 hallo ())))

(pex (all-true-rec '()))
(pex (all-true-rec '(34 hallo (7))))
(pex (all-true-rec '(34 hallo ())))

(terpri)

;;;; 5

(write-line "5")

(trace list-sum)
(list-sum '(1 2 3))
(untrace)


;; print newline
(terpri)