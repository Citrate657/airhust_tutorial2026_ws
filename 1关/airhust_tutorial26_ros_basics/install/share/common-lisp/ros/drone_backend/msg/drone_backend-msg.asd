
(cl:in-package :asdf)

(defsystem "drone_backend-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "DroneState" :depends-on ("_package_DroneState"))
    (:file "_package_DroneState" :depends-on ("_package"))
  ))