; Auto-generated. Do not edit!


(cl:in-package drone_backend-msg)


;//! \htmlinclude DroneState.msg.html

(cl:defclass <DroneState> (roslisp-msg-protocol:ros-message)
  ((armed
    :reader armed
    :initarg :armed
    :type cl:boolean
    :initform cl:nil)
   (mode
    :reader mode
    :initarg :mode
    :type cl:string
    :initform "")
   (altitude
    :reader altitude
    :initarg :altitude
    :type cl:float
    :initform 0.0)
   (setpoint_ok
    :reader setpoint_ok
    :initarg :setpoint_ok
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass DroneState (<DroneState>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DroneState>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DroneState)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name drone_backend-msg:<DroneState> is deprecated: use drone_backend-msg:DroneState instead.")))

(cl:ensure-generic-function 'armed-val :lambda-list '(m))
(cl:defmethod armed-val ((m <DroneState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader drone_backend-msg:armed-val is deprecated.  Use drone_backend-msg:armed instead.")
  (armed m))

(cl:ensure-generic-function 'mode-val :lambda-list '(m))
(cl:defmethod mode-val ((m <DroneState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader drone_backend-msg:mode-val is deprecated.  Use drone_backend-msg:mode instead.")
  (mode m))

(cl:ensure-generic-function 'altitude-val :lambda-list '(m))
(cl:defmethod altitude-val ((m <DroneState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader drone_backend-msg:altitude-val is deprecated.  Use drone_backend-msg:altitude instead.")
  (altitude m))

(cl:ensure-generic-function 'setpoint_ok-val :lambda-list '(m))
(cl:defmethod setpoint_ok-val ((m <DroneState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader drone_backend-msg:setpoint_ok-val is deprecated.  Use drone_backend-msg:setpoint_ok instead.")
  (setpoint_ok m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DroneState>) ostream)
  "Serializes a message object of type '<DroneState>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'armed) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'mode))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'mode))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'altitude))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'setpoint_ok) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DroneState>) istream)
  "Deserializes a message object of type '<DroneState>"
    (cl:setf (cl:slot-value msg 'armed) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'mode) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'mode) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'altitude) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'setpoint_ok) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DroneState>)))
  "Returns string type for a message object of type '<DroneState>"
  "drone_backend/DroneState")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DroneState)))
  "Returns string type for a message object of type 'DroneState"
  "drone_backend/DroneState")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DroneState>)))
  "Returns md5sum for a message object of type '<DroneState>"
  "e14595f56ab4a742f35e88e5269b70c3")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DroneState)))
  "Returns md5sum for a message object of type 'DroneState"
  "e14595f56ab4a742f35e88e5269b70c3")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DroneState>)))
  "Returns full string definition for message of type '<DroneState>"
  (cl:format cl:nil "# 后端对外广播的状态（drone_backend -> 所有人）~%# 字段语义见 README 的“阶段二话题接口表”~%~%bool armed        # 是否已解锁~%string mode       # 当前模式，例如 AUTO.TAKEOFF / HOLD / LAND~%float32 altitude  # 当前高度（米）~%bool setpoint_ok  # 设定点流当前是否有效~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DroneState)))
  "Returns full string definition for message of type 'DroneState"
  (cl:format cl:nil "# 后端对外广播的状态（drone_backend -> 所有人）~%# 字段语义见 README 的“阶段二话题接口表”~%~%bool armed        # 是否已解锁~%string mode       # 当前模式，例如 AUTO.TAKEOFF / HOLD / LAND~%float32 altitude  # 当前高度（米）~%bool setpoint_ok  # 设定点流当前是否有效~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DroneState>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'mode))
     4
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DroneState>))
  "Converts a ROS message object to a list"
  (cl:list 'DroneState
    (cl:cons ':armed (armed msg))
    (cl:cons ':mode (mode msg))
    (cl:cons ':altitude (altitude msg))
    (cl:cons ':setpoint_ok (setpoint_ok msg))
))
