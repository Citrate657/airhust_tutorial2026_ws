#!/usr/bin/env zsh
# 唯一的环境入口。
#
#   source ~/drone_ws/setup.sh
#
# 生效之后：ROS 本体 + 后端（install 空间）+ 你的工作空间，都在环境里。
# 每次 catkin_make 之后重新 source 一次；没 source 就 rosrun，会看到
#   [rospack] Error: package 'drone_bringup' not found
# ——那不是 bug，是环境还没加载。

_ds_ws="$(cd "$(dirname "${(%):-%x}")" && pwd)"
_ds_install="$_ds_ws/install"

# 后端是预编译的，里面的路径是在打包机器上写死的。换了位置就在原地改写一次。
if [ -f "$_ds_install/.build_prefix" ]; then
  _ds_old="$(cat "$_ds_install/.build_prefix")"
  if [ "$_ds_old" != "$_ds_install" ]; then
    grep -rIl --include='*.sh' --include='*.bash' --include='*.zsh' \
      --include='*.cmake' --include='*.pc' --include='*.catkin' \
      "$_ds_old" "$_ds_install" 2>/dev/null \
      | xargs -r sed -i "s|$_ds_old|$_ds_install|g"
    printf '%s\n' "$_ds_install" > "$_ds_install/.build_prefix"
  fi
fi

source "$_ds_install/setup.zsh"

if [ -f "$_ds_ws/devel/setup.zsh" ]; then
  source "$_ds_ws/devel/setup.zsh"
else
  # 还没编译过：先把源码目录放进搜索路径，rospack 才找得到 drone_bringup
  export ROS_PACKAGE_PATH="$_ds_ws/src:$ROS_PACKAGE_PATH"
fi

unset _ds_ws _ds_install _ds_old
