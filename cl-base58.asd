(in-package :cl-user)
(defpackage cl-base58-asd
  (:use :cl :asdf))
(in-package :cl-base58-asd)

(defsystem cl-base58
  :version "0.1"
  :author "Fernando Borretti"
  :license "MIT"
  :homepage "https://github.com/eudoxia0/cl-base58"
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "cl-base58"))))
  :description "An implementation of base58 for Common Lisp"
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.md"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq)))
  :in-order-to ((test-op (test-op cl-base58-test))))
