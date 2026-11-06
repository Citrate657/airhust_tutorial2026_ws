// Auto-generated. Do not edit!

// (in-package drone_backend.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class DroneState {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.armed = null;
      this.mode = null;
      this.altitude = null;
      this.setpoint_ok = null;
    }
    else {
      if (initObj.hasOwnProperty('armed')) {
        this.armed = initObj.armed
      }
      else {
        this.armed = false;
      }
      if (initObj.hasOwnProperty('mode')) {
        this.mode = initObj.mode
      }
      else {
        this.mode = '';
      }
      if (initObj.hasOwnProperty('altitude')) {
        this.altitude = initObj.altitude
      }
      else {
        this.altitude = 0.0;
      }
      if (initObj.hasOwnProperty('setpoint_ok')) {
        this.setpoint_ok = initObj.setpoint_ok
      }
      else {
        this.setpoint_ok = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type DroneState
    // Serialize message field [armed]
    bufferOffset = _serializer.bool(obj.armed, buffer, bufferOffset);
    // Serialize message field [mode]
    bufferOffset = _serializer.string(obj.mode, buffer, bufferOffset);
    // Serialize message field [altitude]
    bufferOffset = _serializer.float32(obj.altitude, buffer, bufferOffset);
    // Serialize message field [setpoint_ok]
    bufferOffset = _serializer.bool(obj.setpoint_ok, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type DroneState
    let len;
    let data = new DroneState(null);
    // Deserialize message field [armed]
    data.armed = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [mode]
    data.mode = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [altitude]
    data.altitude = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [setpoint_ok]
    data.setpoint_ok = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.mode);
    return length + 10;
  }

  static datatype() {
    // Returns string type for a message object
    return 'drone_backend/DroneState';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'e14595f56ab4a742f35e88e5269b70c3';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # 后端对外广播的状态（drone_backend -> 所有人）
    # 字段语义见 README 的“阶段二话题接口表”
    
    bool armed        # 是否已解锁
    string mode       # 当前模式，例如 AUTO.TAKEOFF / HOLD / LAND
    float32 altitude  # 当前高度（米）
    bool setpoint_ok  # 设定点流当前是否有效
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new DroneState(null);
    if (msg.armed !== undefined) {
      resolved.armed = msg.armed;
    }
    else {
      resolved.armed = false
    }

    if (msg.mode !== undefined) {
      resolved.mode = msg.mode;
    }
    else {
      resolved.mode = ''
    }

    if (msg.altitude !== undefined) {
      resolved.altitude = msg.altitude;
    }
    else {
      resolved.altitude = 0.0
    }

    if (msg.setpoint_ok !== undefined) {
      resolved.setpoint_ok = msg.setpoint_ok;
    }
    else {
      resolved.setpoint_ok = false
    }

    return resolved;
    }
};

module.exports = DroneState;
