#|
  This file is a part of cl-base58 project.
  Copyright (c) 2014 Fernando Borretti (eudoxiahp@gmail.com)
|#

(in-package :cl-user)
(defpackage cl-base58-test-asd
  (:use :cl :asdf))
(in-package :cl-base58-test-asd)

(defsystem cl-base58-test
  :author "Fernando Borretti"
  :license "MIT"
  :depends-on (:cl-base58
               :cl-test-more)
  :components ((:module "t"
                :components
                ((:test-file "cl-base58"))))

  :defsystem-depends-on (:cl-test-more)
  :perform (test-op :after (op c)
                    (funcall (intern #. (string :run-test-system) :cl-test-more)
                             c)
                    (asdf:clear-system c)))
