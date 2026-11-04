// example_listener：完整可运行的示例节点。
//
// 订阅 /drone/state 并打印。用它确认三件事：
//   1) 后端在说话（rosrun 起来后有没有输出）；
//   2) 话题名字对不对（./run_sim.sh 起了 sim 之后再看）；
//   3) 一个完整的“订阅 + 回调 + spin”长什么样。
//
// 建议顺序：先 rosrun 它，再照它的写法补全 takeoff_node / avoid_node。

#include <ros/ros.h>
#include <drone_backend/DroneState.h>

void onState(const drone_backend::DroneState::ConstPtr& msg) {
  ROS_INFO_STREAM("armed=" << (msg->armed ? "true" : "false")
                           << " mode=" << msg->mode
                           << " altitude=" << msg->altitude
                           << " setpoint_ok=" << (msg->setpoint_ok ? "true" : "false"));
}

int main(int argc, char** argv) {
  ros::init(argc, argv, "example_listener");
  ros::NodeHandle nh;

  ros::Subscriber state_sub = nh.subscribe("/drone/state", 10, onState);

  ROS_INFO("example_listener ready");
  ros::spin();

  return 0;
}
