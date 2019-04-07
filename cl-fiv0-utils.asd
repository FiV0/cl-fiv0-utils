;;;; cl-fiv0-utils.asd

(asdf:defsystem #:cl-fiv0-utils
  :description "Some utilities I found useful and couldn't find in other packages."
  :author "finn.volkel@gmail.com"
  :license  "MIT licence"
  :version "0.0.1"
  :serial t
  :depends-on (:flexi-streams )
  :components ((:file "package")
               (:file "cl-fiv0-utils")))
