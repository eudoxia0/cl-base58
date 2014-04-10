(in-package :cl-user)
(defpackage base58
  (:use :cl)
  (:export :encode
           :decode))
(in-package :base58)

;; from https://bitcointalk.org/index.php?topic=1026.0

(defparameter +alphabet+
  "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz")
(defparameter +len+
  (length +alphabet+))

(defun divmod (number divisor)
  (values (floor (/ number divisor))
          (mod number divisor)))

(defun encode (str)
  (let ((value 0) ;; Not exactly descriptive, but I don't really understand what
                  ;; this does anyways.
        (rstr (reverse str))
        (output (make-string-output-stream))
        (npad 0)) ; The number of leading zeroes that are to be removed

    (loop for i from 0 to (1- (length str)) do
      (setf value (+ value (* (char-code (elt rstr i))
                              (expt 256 i)))))

    (loop while (>= value +len+) do
      (multiple-value-bind (new-value mod) (divmod value +len+)
        (setf value new-value)
        (write-char (elt +alphabet+ mod) output)))
    (write-char (elt +alphabet+ value) output)
   
    (loop for char across str do ;; Count the leading zeroes
      (if (char-equal char #\Nul)
          (incf npad)
          (return)))

    (concatenate 'string
                 (coerce (loop for i from 1 to npad collecting #\1) 'string)
                 (reverse (get-output-stream-string output)))))

(defun decode (str &optional length)
  (let ((value 0)
        (rstr (reverse str))
        (output (make-string-output-stream))
        (npad 0))
    
    (loop for i from 0 to (1- (length str)) do
      (setf value (+ value (* (position (elt rstr i) +alphabet+)
                              (expt +len+ i)))))

    (loop while (>= value 256) do
      (multiple-value-bind (new-value mod) (divmod value 256)
        (setf value new-value)
        (write-char (code-char mod) output)))
    (write-char (code-char value) output)

    (loop for char across str do ;; Count the leading ones
      (if (char-equal char #\1)
          (incf npad)
          (return)))

    (setf output (concatenate 'string
                              (coerce (loop for i from 1 to npad collecting #\Nul)
                                      'string)
                              (reverse (get-output-stream-string output))))

    (if (and length (not (eql length (length output))))
        nil
        output)))
