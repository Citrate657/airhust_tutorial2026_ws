# 阶段三：先学会用人家的函数

这一阶段的目标很简单啊：**知道 PCL 里有哪些现成的工具，并且会调用**

这里需要你补全我们代码部分的TODO

## 目录

- [README](../README.md)
  - **阶段三：先学会用人家的函数 ←**
    - [3.1 点云在内存里怎么存](01-io.md)
    - [3.2 用 rviz 看](02-rviz.md)
    - [3.3 滤波](03-filter.md)
    - [3.4 找邻居](04-kdtree.md)
    - [3.5 聚簇](05-cluster.md)
    - [3.6 点云哪来的](06-cloud-register.md)
    - [3.7 进仿真](07-sim.md)
    - [3.8 扩展](08-extend.md)

## 准备工作

### 代码在哪

```
airhust_tutorial26_pcl_ws/
├── run                            # 启动脚本：./run 3
├── data/                          # 数据
│   ├── demo_room.pcd              # 点云文件：模拟房间，112400 个点
│   ├── demo_room_noisy.pcd        # 同样的房间，加了冗余和噪声（3.3 用）
│   ├── make_demo_scene.py         # 生成上面那个房间的脚本，好奇可以看
│   └── make_noisy.py              # 在房间上加冗余和噪声的脚本
├── out/                           # 程序输出保存到这里
├── docs/                          # 就是你正在看的这些 md，一节一个文件
└── src/
    └── tutorial_pcl_basic/        # 本阶段的包
        └── src/                   # 练习源码所在位置
```

### 怎么编译

```shell
cd ~/airhust_tutorial26_pcl_ws
catkin_make --pkg tutorial_pcl_basic
source devel/setup.zsh
```

### 怎么跑

仓库根目录有个 `run` 脚本，`source` 和 `rosrun` 都替你做了

命令示例如下：

```shell
./run 3                                  # 跑第 3 个练习
./run 3 data/table_scene_lms400.pcd      # 该命令的第二个参数作为程序的第一个参数传给程序（argv[1]）
```

不带参数跑 `./run` 会打印用法。

### 关于数据

**`pcd`** Point Cloud Data
顾名思义，存点云的文件

`data/demo_room.pcd` 不是真实场景，是造出来的一个 8m × 6m × 2.6m 的房间：地面、四面墙、一张 0.75m 高的桌子、桌上三个零件、房间中间两根柱子（半径 0.22m 和 0.35m）。

点云数据可以通过pcd文件进行储存和读取（pcl中有相关IO模块）

然而实际运行过程中是内存中的点云数据，往往不会作为点云文件储存下来。

### 参考答案

`solutions/` 包含与练习对应的参考答案。可以直接阅读，也可以独立编译运行：

```shell
catkin_make --pkg tutorial_pcl_basic -DTUTORIAL_BUILD_SOLUTIONS=ON
./run --solution 3
```

这会生成名称以 `solution_` 开头的可执行文件，学生源码保持原样。`./run 3` 始终运行学生程序。文档中的完整运行结果来自参考答案；未填的占位函数只展示流程，不能用来验证算法效果。

### 小节和程序编号

程序编号对应源码文件名；阅读小节没有独立程序：

| 小节 | 源码 | 运行命令 |
| --- | --- | --- |
| 3.1 点云存储 | `01_io.cpp` | `./run 1` |
| 3.2 rviz | `02_publish.cpp` | `./run 2` |
| 3.3 滤波 | `03_filter.cpp` | `./run 3` |
| 3.4 邻居搜索 | 阅读与参数理解 | 无独立程序 |
| 3.5 聚类 | `05_cluster.cpp` | `./run 5` |
| 3.6 数据来源与采集 | 按文档准备输入 | 复用前面程序 |
| 3.7 在线处理练习 | `07_pipeline.cpp` | `./run 7` |

### 开发和体验工作空间

`airhust_tutorial26_pcl_ws` 保存课程源码和参考答案，`airhust_tutorial26_pcl_ws_trial` 用于实际完成练习。两边同步文档、数据、公共代码和未完成的架子；体验空间里已经填写的练习保留各自内容，需要调整接口时迁移已有实现。编译产物、输出文件和各自 `.git` 不参与同步。

**下一步请来到[3.1 点云在内存里怎么储存的](01-io.md)**
