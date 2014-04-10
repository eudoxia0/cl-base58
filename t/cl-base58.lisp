(in-package :cl-user)
(defpackage cl-base58-test
  (:use :cl :base58 :test-more))
(in-package :cl-base58-test)

(plan 8)

;; Encoding
(is (encode "derp") "3ZqqXd")
(is (encode "1") "r")
(is (encode "the quick brown fox") "NK2qR8Vz63NeeAJp9XRifbwahu")
(is (encode "THE QUICK BROWN FOX") "GRvKwF9B69ssT67JgRWxPQTZ2X")

;; Decoding without length
(is (decode "3ZqqXd") "derp")
(is (decode "r") "1")
(is (decode "NK2qR8Vz63NeeAJp9XRifbwahu") "the quick brown fox")
(is (decode "GRvKwF9B69ssT67JgRWxPQTZ2X") "THE QUICK BROWN FOX")

(finalize)
