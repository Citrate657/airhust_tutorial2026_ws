#!/usr/bin/env zsh
# 起后端：roscore（没起就顺手起）+ sensor_node + drone_sim_node。
#
#   ./run_sim.sh
#
# drone_sim_node 在前台跑：它判定成功降落后打印结果并退出，脚本跟着收掉 sensor。

set -o pipefail


export ROS_MASTER_URI="${ROS_MASTER_URI:-http://127.0.0.1:11311}"

RC_PID=""
SEN_PID=""

cleanup() {
  trap - INT TERM EXIT
  [ -n "$SEN_PID" ] && kill "$SEN_PID" 2>/dev/null
  [ -n "$RC_PID" ] && kill "$RC_PID" 2>/dev/null
  wait 2>/dev/null
  printf '\n%s\n' "后端已停止。"
  exit 0
}
trap cleanup INT TERM EXIT

if rosnode list >/dev/null 2>&1; then
  printf '%s\n' "== 已有 roscore（$ROS_MASTER_URI），直接使用"
else
  printf '%s\n' "== 启动 roscore（$ROS_MASTER_URI）"
  roscore &
  RC_PID=$!
  for _ in $(seq 1 60); do
    rosnode list >/dev/null 2>&1 && break
    sleep 0.25
  done
fi

printf '%s\n' "== 启动 sensor_node（后台）"
rosrun drone_backend sensor_node &
SEN_PID=$!

printf '%s\n' "== 启动 drone_sim_node（前台；成功降落后会自己退出）"
printf '%s\n' "   另开一个终端跑你的节点：roslaunch drone_bringup mission.launch"
rosrun drone_backend drone_sim_node
