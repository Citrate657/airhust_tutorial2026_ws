# 后端对外广播的状态（drone_backend -> 所有人）
# 字段语义见 README 的“阶段二话题接口表”

bool armed        # 是否已解锁
string mode       # 当前模式，例如 AUTO.TAKEOFF / HOLD / LAND
float32 altitude  # 当前高度（米）
bool setpoint_ok  # 设定点流当前是否有效
