# 板块四 · 仿真单元测试

## 这一板块在干嘛

亲爱的学弟学妹们，恭喜你们到了第四个板块，仿真单元测试。

在第三个板块中，你在离线图片上把颜色、二维码、AprilTag、OCR、YOLO 都跑过了一遍。

在这个板块中，你就需要开始做一些和无人机相关的事情了

这一板块的目标是：你需要在仿真环境中用无人机的下视摄像头测试你的视觉识别代码。

这个板块依旧是五关，我准备了五张地图，分别对应了上个板块中的五种内容

这五关用的地图都在 `lab_vision_sim_task4` 这个包里，world 放地图，models 放靶标，launch 负责起 PX4、MAVROS 和 Gazebo。

## 环境测试

先看看你的环境是否有问题，这是整个视觉仿真能跑起来的前提：

起第一关试试：

```bash
cd ~/airhust_tutorial26_vision_lab
catkin_make
```
然后打开 `~/.zshrc`：

```bash
nano ~/.zshrc
```

最后应该有这么三行（镜像里本来就有，没有的话自己补上）：

```bash
export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:$HOME/airhust_ws/src
export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:$HOME/PX4-Autopilot
export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:$HOME/PX4-Autopilot/Tools/sitl_gazebo
```

第一行是 `simulation` 包的位置，下视相机的模型在那里；后两行是 PX4 的。把这个工作空间的 source 加到这三行**上面**：

```bash
source ~/airhust_tutorial26_vision_lab/devel/setup.zsh
```

catkin 的 `setup.zsh` 会重写 `ROS_PACKAGE_PATH`，所以它必须在前面，不然上面那三行会被冲掉，`roslaunch` 会报 `Resource not found: px4`。

然后他看起来就像是

```bash
source ~/airhust_tutorial26_vision_lab/devel/setup.zsh
export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:$HOME/airhust_ws/src
export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:$HOME/PX4-Autopilot
export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:$HOME/PX4-Autopilot/Tools/sitl_gazebo
```

然后
```bash
source ~/.zshrc
roslaunch lab_vision_sim_task4 task1.launch
```

正常情况下 Gazebo 里会出现一块 20×20 的灰色地面，无人机停在原点，机头朝 +x，前面 x=1 的位置摆着三个色块。

注：launch 里已经把 `GAZEBO_MODEL_PATH` 指到 `lab_vision_sim_task4/models`，不用再往 `~/.gazebo/models` 拷靶标。如果你绕过 launch 直接 `gazebo task1.world`，那就得自己拷模型，不然靶标加载不出来。

## 地图和包里有什么

```
lab_vision_sim_task4/
├── launch/
│   ├── task1.launch      第一关：三个色块
│   ├── task2.launch      第二关：二维码
│   ├── task3.launch      第三关：AprilTag
│   ├── task4.launch      第四关：AIRHUST 文字
│   └── task5.launch      第五关：AirHust logo
├── worlds/
│   ├── task1.world
│   ├── task2.world
│   ├── task3.world
│   ├── task4.world
│   └── task5.world
├── models/
│   ├── qr_pad/           0.6×0.6 二维码靶标
│   ├── tag_pad/          0.6×0.6 AprilTag 靶标
│   ├── text_pad/         0.6×0.6 文字靶标
│   └── logo_pad/         0.6×0.6 logo 靶标
└── config/px4_config.yaml
```

每张地图里，无人机都出生在 `(0,0)`，机头朝 `+x`

## 五关一览

| 关卡 | 目标             | 你要交出的结果        | 降落点      |
| -- | -------------- | -------------- | -------- |
| 一  | 红绿蓝三个色块        | 三个颜色分别打印到终端    | 蓝色色块     |
| 二  | 二维码            | 解出来的字符串        | 二维码上     |
| 三  | AprilTag 36h11 | 标签编号           | 标签上      |
| 四  | AIRHUST 文字     | 识别出的文字         | 文字靶标上    |
| 五  | AirHust logo   | 自己训的模型能检出 logo | logo 靶标上 |

## 第一关：三个色块

地图 `task1.world`，三个半径 0.3 米的圆：红色在 `(1,-1)`，绿色在 `(1,0)`，蓝色在 `(1,1)`。

任务流程：

1. 起飞，到 1.5 米左右悬停
2. 依次飞到三个色块上方，用下视相机识别正下方的颜色
3. 每识别到一个，就在终端打印出来，比如 `red`、`green`、`blue`
4. 三个都走完，飞到蓝色色块上方降落

识别部分可以直接用板块三第一关的 `inRange` 。色块是纯红、纯绿、纯蓝，白底。或者你也可以探究一下hsv在颜色识别这一块的应用。一般来说，实际任务中，我们会更偏向于用hsv而不是RGB

## 第二关：二维码

地图 `task2.world`，`(1,0)` 放了一张 0.6×0.6 的二维码，里面的内容是一个神秘字符串

任务流程：

1. 起飞，飞到二维码上方
2. 用下视相机解码，把字符串打印到终端
3. 降落在二维码上

解码器建议先试 `detectAndDecodeMulti`，没结果再退回 `detectAndDecode`，板块三第二关应该写过。

## 第三关：AprilTag

地图 `task3.world`，`(1,0)` 放了一张 0.6×0.6 的 AprilTag，家族是 36h11（6×6 个格子）

任务流程和第二关一样：起飞、到标签上方、解码、把编号打印到终端、降落在标签上。

注意家族别选错。36h11 是 `cv2.aruco.DICT_APRILTAG_36H11`，用成 25h9 的话一个都检测不到，而且不报错。

## 第四关：AIRHUST 文字

地图 `task4.world`，`(1,0)` 放了一张 0.6×0.6 的图，白底黑字，内容是 `AIRHUST`。

任务流程还是起飞、到上方、识别、打印、降落。这关不用训练模型，直接调 tesseract 就行，板块三第四关已经装过、也写过一遍。

如果读出来是空的，先检查二值化有没有搞反，再试试 `--psm 6` 或 `--psm 7`。文字是横排的一行，`--psm 7` 有时候更好。

## 第五关：AirHust logo

地图 `task5.world`，`(1,0)` 贴了一张 0.6×0.6 的 AirHust logo。

这一关和前面几关不一样，没有现成模型，你要自己训一个：

1. 拿 `airhust_tutorial26_vision_lab/src/lab_vision_sim_task4/models/logo_pad/materials/textures/logo.png` 做数据增强，造训练集。旋转、缩放、透视、亮度对比度、换背景、加噪声，能想到的都往上加。
2. 标注成 YOLO 格式，训一个检测模型。底座用任何yolo的nano模型都行。
3. 把模型接进节点，飞到 logo 上方检测。
4. 在靶标上面降落

数据增强可以看这个仓库：<https://github.com/FirmamentumX/Realscene-Yolo>。

yolo如何训练可以在b站看看这个视频：<https://www.bilibili.com/video/BV1d1W9z9E2G/?spm_id_from=333.337.search-card.all.click>

## 图像怎么进来
首先你需要装一个ros和opencv的桥接器

```bash
sudo apt install ros-noetic-cv-bridge
```

仿真里是没有 `cv2.imread`这种东西的，图像都是话题发过来的。Python 节点里大概长这样：

```python
import rospy
from sensor_msgs.msg import Image
from cv_bridge import CvBridge

bridge = CvBridge()


def image_callback(msg):
    frame = bridge.imgmsg_to_cv2(msg, desired_encoding="bgr8")
    # frame 就是 numpy 数组，直接喂给板块三的函数


rospy.init_node("vision_node")
rospy.Subscriber("/usb_cam/image_raw", Image, image_callback, queue_size=1)
rospy.spin()
```

`imgmsg_to_cv2` 要指定 `bgr8`，不然通道顺序可能不对。处理完的结果用 `rospy.loginfo` 打印，或者发到话题上，具体看关卡要求

## 贴图朝向

四张靶标的贴图已经按实际显示方向调好了，无人机从原点朝 +x 看过去，文字和二维码都是正的，不用自己再改。

如果你换了自己的贴图，发现显示出来转了 90 度，那是 Gazebo 平面贴图的 UV 导致的，把图片本身旋转一下就行。

## 常见问题

| 现象                     | 大概原因               | 怎么办                                                       |
| ---------------------- | ------------------ | --------------------------------------------------------- |
| Gazebo 里只有地面，没有靶标      | 模型路径没生效            | 用 launch 启动，别直接 `gazebo xxx.world`                        |
| 靶标是白块或黑块               | 贴图没加载              | 检查 `GAZEBO_MODEL_PATH`，确认 `models/*/materials/textures` 在 |
| 没有 `/usb_cam/image_raw` | 相机插件没起来，或者话题名不对 | launch 里 spawn 的是 `iris_down_cam`，模型里已经带了下视相机，用 `rostopic list` 确认一下话题 |
| 二维码解不出来                | 白边被裁、图太小、对焦不清      | 飞低一点，确认整张码在画面里                                            |
| AprilTag 检测不到          | 家族选错               | 36h11 用 `DICT_APRILTAG_36H11`                             |
| OCR 读出空串               | 二值化反了、psm 不对       | 用 `THRESH_BINARY`，试 `--psm 6/7`                           |
| YOLO 检测不到 logo         | 训练集太单一             | 多做数据增强，换背景、换角度                                            |
| 降落时冲过头                 | 速度环系数太大            | 把比例系数调小，加死区                                               |

## 写在最后

能看到这里，说明你已经完成所有关卡，偶美跌头！

接下来你可以找寻你的队友，一起做后面的大任务。

期待与你在airhust的相会！

如果有任何关于视觉板块的梯队任务的吐槽，请联系2025级肚腩特大哥