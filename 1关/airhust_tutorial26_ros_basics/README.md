# Airhust 26梯队任务 一

**考察**：catkin编译环境配置，基础ros通信概念

**任务**：家豪gg想让一架“半成品无人机”完成一次稳定起飞，并在障碍物前停下来。可是今早起来他的ws不知怎的被狗啃了（对被狗啃了），并且没有使用git版本管理（警钟长鸣！！！），好心的你可以帮帮他吗（你可以

**要求**：可以使用AI查找知识，辅助理解，但严禁使用agent一键爆破

---

## 0. 简化声明

这套“无人机”只是**简化的情境**，以避免繁杂的仿真启动步骤
**它不是 真实PX4，MAVROS（后面各阶段马上会接触到）**，各接口只是模拟真实接口语义。

---

## 1. 快速上手

| 路径 | 属性 |
|---|---|
| `src/drone_bringup/` | 被狗啃的地方，需要你来修理修理 |
| `install/` | 已编译好的后端文件，请勿删除；<br>编译时如需要drone_backend包做依赖，请source install/setup.zsh |
| `run_sim.sh` | 只启动后端（sim + sensor），方便你单独调 |
| `mission.launch` | 一键起 sim + sensor + 你的节点（在 `src/drone_bringup/launch/`） |

```bash
# 可以试试启动节点
roslaunch drone_bringup mission.launch
```

---

## 2. 阶段一：oops！环境/依赖/编译 遇到了亿点点小问题

家豪gg本想启动他的节点，咦？找不到节点？哦哦哦一定是没有编译吧。输入catkin_make编译后······唯有ERRORS ಥ_ಥ

请快帮他修理修理吧，家豪gg快要哭出来啦

### 2.1 阶段目标：`catkin_make` 通过，且 `roslaunch drone_bringup mission.launch` 能把`flight_node` 节点起起来

### 2.2 提示：阶段一只需简单修改`drone_bringup`包内的`CMakeLists.txt` `package.xml`即可，不涉及其他文件修改

### 2.3 你可能需要了解

- `~/.zshrc`中`source /opt/ros/noetic/setup.zsh`，`source ~/airhust_ws/devel/setup.zsh`都有什么用？（初始无devel目录，可尝试先编译一次）
- `CMakeLists.txt` `package.xml`的作用分别是？
- ros文件层级概念

---

## 3. 阶段二：哦天哪！我的飞机会飞

搞定了环境和依赖的难题，家豪gg终于启动了控制节点。桥豆麻袋(⊙ˍ⊙) 飞机怎么不会飞！

请你再次帮帮家豪gg的飞机起飞吧，一定要在障碍物前停下来哦OwO

### 3.1 本关定义的接口

飞机提供了一些ros话题以供你获取飞机信息/控制飞机（我真得控制它了

| 方向 | 话题 | 类型 | 作用 |
|---|---|---|---|
| 后端 → 你 | `/drone/state` | `drone_backend/DroneState`（`armed` / `mode` / `altitude` / `setpoint_ok`） | 获取飞机各项状态信息 |
| 你 → 后端 | `/drone/setpoint` | `geometry_msgs/PoseStamped` | 设定飞机目标点 |
| 传感器 → 你 | `/drone/sensor/obstacle_distance` | `std_msgs/Float32`（米） | 获取当前飞机距障碍物距离 |

其中自定义消息`drone_backend/DroneState`定义如下

``` cpp
bool armed        # 是否已解锁
string mode       # 当前模式，例如 AUTO.TAKEOFF / HOLD / LAND
float32 altitude  # 当前高度（米）
bool setpoint_ok  # 设定点流当前是否有效(即是否满足心跳)
```

### 3.2 阶段目标

#### 2A —— 起飞

- 维持 **500ms** 心跳
- `altitude` 升到 **1.5 m**

#### 2B —— 避障

成功起飞后飞机会不断接近障碍物

- 障碍距离 **< 0.5 m** 之后，降落（`altitude` 回到 0。）

### 3.3 任务启动

在两个终端中分别执行：

```bash
# 终端 1：模拟/判定后端
./run_sim.sh

# 终端 2：你的节点
roslaunch drone_bringup mission.launch
```

---

终于——在你的帮助下，家豪gg完成了task1，前方还有什么在等着他呢(⊙o⊙)······

## 4. 你要commit什么

1. 补充完整的源码
2. 一份MD，整理每一处补充/修改 你运用了/学到了什么知识
   - 非强制，但展示你的诚意
   - 如果能附上思考路径更佳
