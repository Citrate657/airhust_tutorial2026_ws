// 标了 TODO 的地方需要你补全/修改
#include <ros/ros.h>
#include <geometry_msgs/PoseStamped.h>
#include <std_msgs/Float32.h>

double distance = 2.0;

void obstacle_cb(const std_msgs::Float32::ConstPtr& msg) {
  distance = msg->data;
}

int main(int argc, char** argv) {
  ros::init(argc, argv, "flight_node");
  ros::NodeHandle nh;

  // TODO: 飞控连接有500ms的心跳包，那这里至少要填多少呢？应该可以填大一些
  ros::Rate rate(10.0);

  ros::Publisher g_setpoint_pub = nh.advertise<geometry_msgs::PoseStamped>("/drone/setpoint", 10);

  ros::Subscriber obstacle_sub = nh.subscribe(
      "/drone/sensor/obstacle_distance", 10, obstacle_cb);   // TODO：我也要sub吗···

  geometry_msgs::PoseStamped setpoint;
  setpoint.header.frame_id = "map";
  setpoint.pose.position.x = 0.0;
  setpoint.pose.position.y = 0.0;
  setpoint.pose.position.z = 1.5;  // TODO: **我让你飞起来



  ROS_INFO("flight_node ready");
  while (ros::ok()) {

    if (distance < 0.5) {  // TODO：停不下来了啊
      setpoint.pose.position.z = 0;
    }

    setpoint.header.stamp = ros::Time::now();  // TODO: stamp需要填什么呢？
    g_setpoint_pub.publish(setpoint);  // TODO：到底在发些什么啊
    ros::spinOnce();
    rate.sleep();
  }

  ROS_INFO("flight_node stopped");
  return 0;
}
