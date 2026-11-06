;; Auto-generated. Do not edit!


(when (boundp 'drone_backend::DroneState)
  (if (not (find-package "DRONE_BACKEND"))
    (make-package "DRONE_BACKEND"))
  (shadow 'DroneState (find-package "DRONE_BACKEND")))
(unless (find-package "DRONE_BACKEND::DRONESTATE")
  (make-package "DRONE_BACKEND::DRONESTATE"))

(in-package "ROS")
;;//! \htmlinclude DroneState.msg.html


(defclass drone_backend::DroneState
  :super ros::object
  :slots (_armed _mode _altitude _setpoint_ok ))

(defmethod drone_backend::DroneState
  (:init
   (&key
    ((:armed __armed) nil)
    ((:mode __mode) "")
    ((:altitude __altitude) 0.0)
    ((:setpoint_ok __setpoint_ok) nil)
    )
   (send-super :init)
   (setq _armed __armed)
   (setq _mode (string __mode))
   (setq _altitude (float __altitude))
   (setq _setpoint_ok __setpoint_ok)
   self)
  (:armed
   (&optional (__armed :null))
   (if (not (eq __armed :null)) (setq _armed __armed)) _armed)
  (:mode
   (&optional __mode)
   (if __mode (setq _mode __mode)) _mode)
  (:altitude
   (&optional __altitude)
   (if __altitude (setq _altitude __altitude)) _altitude)
  (:setpoint_ok
   (&optional (__setpoint_ok :null))
   (if (not (eq __setpoint_ok :null)) (setq _setpoint_ok __setpoint_ok)) _setpoint_ok)
  (:serialization-length
   ()
   (+
    ;; bool _armed
    1
    ;; string _mode
    4 (length _mode)
    ;; float32 _altitude
    4
    ;; bool _setpoint_ok
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _armed
       (if _armed (write-byte -1 s) (write-byte 0 s))
     ;; string _mode
       (write-long (length _mode) s) (princ _mode s)
     ;; float32 _altitude
       (sys::poke _altitude (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _setpoint_ok
       (if _setpoint_ok (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _armed
     (setq _armed (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; string _mode
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _mode (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; float32 _altitude
     (setq _altitude (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _setpoint_ok
     (setq _setpoint_ok (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get drone_backend::DroneState :md5sum-) "e14595f56ab4a742f35e88e5269b70c3")
(setf (get drone_backend::DroneState :datatype-) "drone_backend/DroneState")
(setf (get drone_backend::DroneState :definition-)
      "# 后端对外广播的状态（drone_backend -> 所有人）
# 字段语义见 README 的“阶段二话题接口表”

bool armed        # 是否已解锁
string mode       # 当前模式，例如 AUTO.TAKEOFF / HOLD / LAND
float32 altitude  # 当前高度（米）
bool setpoint_ok  # 设定点流当前是否有效

")



(provide :drone_backend/DroneState "e14595f56ab4a742f35e88e5269b70c3")


