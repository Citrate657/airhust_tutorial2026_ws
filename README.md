# AirHUST 2026 梯队培训

亲爱的小朋友们和大朋友们你们好呀，欢迎来到**嘉豪哥哥奇妙的无人机小课堂**。
下面，你将探索奇妙的无人机小世界，由于大部分内容都是我们手写的，我们希望你们在前三关的时候仅仅将AI作为提问的工具，而不是让AI直接帮你操作哦。
你能做到吗？
你一定可以的。

## 关卡目录

| 关卡 | 内容 | 当前状态 |
| --- | --- | --- |
| [第 1 关](1关/README.md) | 环境搭建与基础 ROS 通信 | 完整 |
| [第 2 关](2关/README.md) | 阅读 template、理解控制流并实现绕圈 | 完整 |
| [第 3 关](3关/) | 分方向补齐关键代码 | 点云、视觉、避障 |
| [第 4 关](4关/) | 分方向完成小场景任务 | 视觉、避障、与点云 |
| [第 5 关](5关/) | 组队完成多方向融合项目 | 待补充 |

## 如何复制练习

先在第一关的 Linux 环境中克隆总仓库：

```bash
cd ~
git clone https://github.com/HarryGit-HUST/airhust_tutorial2026_ws.git
cd ~/airhust_tutorial2026_ws
```

然后按下面的方法复制自己要做的任务。除第二关只取出 `template` 包外，其余任务都要复制完整目录。目标目录请使用尚不存在的路径，避免覆盖已有练习；不要把总仓库整体放入某个工作空间的 `src`。

| 任务 | 在总仓库根目录执行 | 原作者题目与讲义 |
| --- | --- | --- |
| 第一关 | `cp -a '1关/基础通信任务' ~/drone_ws` | [基础通信任务](1关/基础通信任务/README.md) |
| 第二关 | `mkdir -p ~/template_ws/src`，再执行 `cp -a 2关/src/template ~/template_ws/src/` | [template 入门](2关/第二关-template入门.md)、[练习与绕圈任务](2关/第二关-练习与绕圈任务.md) |
| 点云方向 | `cp -a '3关/点云' ~/airhust_tutorial26_pcl_ws` | [PCL 讲义](3关/点云/docs/index.md) |
| 视觉方向 | `cp -a '3关/视觉' ~/airhust_tutorial26_vision_lab` | [第三关](<3关/视觉/src/板块3 函数原型与静态调用/README.md>)、[第四关](<3关/视觉/src/板块4 仿真单元测试/README.md>) |
| 避障方向 | `cp -a '3关/避障' ~/template2026_ws` | [算法补全与仿真任务](3关/避障/collision_avoidance.md) |

第四关继续使用对应方向的个人工作空间，不再复制一份。复制完成后，编译和运行按各任务的原始讲义进行。

<!-- 收录来源与固定版本，保留原作者文件：
第一关：https://github.com/consefact/tutor_26_misson1/tree/185f156e3566f2eba56168737e4cb652fdc6c26f
点云：https://github.com/RgerColdline/airhust_tutorial26_pcl_ws/tree/9cf903f916d30dba3e807ee398f124a7bfa5d038
视觉：https://github.com/dunantedage1/airhust_tutorial26_vision_lab/tree/b8c3286636602fb095630d06bc5b3acedddb306f
避障：https://github.com/yan233966/airhust_tutorial26_collision_avoidance/tree/b1b8bb52ab9327f8a82d456e3db9428fa309da81
-->
