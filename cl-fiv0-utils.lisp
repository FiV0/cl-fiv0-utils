;;;; cl-fiv0-utils.lisp

(in-package #:cl-fiv0-utils)

;; Authentication
(defun read-token (filepath)
  "Reads a oneline token from FILEPATH."
  (with-open-file (s path :if-does-not-exist nil)
    (read-line s)))

;; Strings
(defun split-string (str index)
  "Splits STR at INDEX and returns the two subsequences."
  (values (subseq str 0 index) (subseq str index)))

;; Lists
(defun find-next-after (lst element &key (test #'eq))
  "Finds the element coming after ELEMENT in LST. Equality is checked with
   an optional TEST function. Expects the the next element to exist in case
   ELEMENT is found."
  (cond ((null lst) nil)
        ((funcall test (car lst) element) (cadr lst))
        (T (find-next (cdr lst) element :test test))))

;; Binary manipulation.
(defun readlines-from-octet-array (octets)
  "Readlines from OCTETS."
  (flexi-streams:with-input-from-sequence (in octets)
    (let ((in (flexi-streams:make-flexi-stream in)))
      (loop for line = (read-line in nil)
            while line collect line))))


;; File IO
(defun readlines-from-file (filepath)
  "Reads all lines from FILEPATH."
  (with-open-file (in filepath :if-does-not-exist nil )
    (loop for line = (read-line in nil)
          while line collect line)))

(defun file-get-contents (filepath)
  "Reads whole file into a string."
  (with-open-file (stream filepath)
    (let ((contents (make-string (file-length stream))))
      (read-sequence contents stream)
      contents)))

;; Pretty printing
(defun print-hashtable (ht stream)
  "Pretty print a HT to STREAM."
  (format stream "#HASH{~{~{(~a : ~a)~}~^ ~}}"
          (loop for key being the hash-keys of ht
                using (hash-value value)
                collect (list key value))))

;; Symbols
(defun get-all-symbols (&optional package)
  "Get all symbols of a PACKAGE."
  (let ((lst ())
        (package (find-package package)))
    (do-all-symbols (s lst)
      (when (fboundp s)
        (if package
            (when (eql (symbol-package s) package)
              (push s lst))
            (push s lst))))
    lst))

(defun get-external-symbols (&optional package)
  "Get all external symbols of a PACKAGE."
  (let ((lst ()))
    (do-external-symbols (s (find-package package) lst)
      (push s lst))
    lst))
