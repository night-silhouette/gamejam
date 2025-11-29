extends Node2D

@onready var left: Sprite2D = $left
@onready var middle: Sprite2D = $middle
@onready var right: Sprite2D = $right

var need_to_change:bool = false

# --- 布局常量定义 ---
# 假设这是默认的 X 坐标
const LEFT_DEFAULT_X: float = -100.0  # 假设左侧 Sprite2D 的默认 X 坐标
const MIDDLE_DEFAULT_X: float = 0.0    # 假设中间 Sprite2D 的默认 X 坐标
const RIGHT_DEFAULT_X: float = 100.0   # 假设右侧 Sprite2D 的默认 X 坐标

# 两位数时，left 和 right 移动到的紧凑 X 坐标
# 假设我们希望它们相对于中心点 (0.0) 的距离更小，例如从 +/- 100 变为 +/- 50
const TIGHT_OFFSET_X: float = 50.0 
# --- 预加载资源（保持不变） ---
const _0 = preload("uid://r1ren270yj76")
const _1 = preload("uid://cjrqjvbw1fruy")
const _2 = preload("uid://c60q66h04ad6m")
const _3 = preload("uid://5665qvsvfqe6")
const _4 = preload("uid://cukcgcn6210qc")
const _5 = preload("uid://dhfa0daxoty2f")
const _6 = preload("uid://coal4gmvroyk4")
const _7 = preload("uid://bb5n6e2v7j205")
const _8 = preload("uid://kjsep4yyjb2u")
const _9 = preload("uid://cj2ry54tvhkwm")

var number_map = {0: _0, 1: _1, 2: _2, 3: _3, 4: _4, 5: _5, 6: _6, 7: _7, 8: _8, 9: _9}

# --- 调整后的属性设置器 ---
var value:int:
	set(new_value):
		var temp_value = new_value
		value = temp_value
		
		# 每次更新前，先清除所有 Sprite2D 的贴图
		left.texture = null
		middle.texture = null
		right.texture = null
		
		# 每次更新前，先将所有 Sprite2D 的位置**重置**到默认三位数时的位置
		left.position.x = LEFT_DEFAULT_X
		middle.position.x = MIDDLE_DEFAULT_X
		right.position.x = RIGHT_DEFAULT_X

		# 2. 将整数分解为百位、十位和个位
		var hundreds = value / 100
		var tens = (value % 100) / 10
		var ones = value % 10
		
		# 3. 根据值的大小进行特殊显示
		
		# A. 一位数: 0 <= value <= 9
		if value <= 9:
			# 一位数时，可以考虑让 middle 保持在中心，或者移动到 left 的位置
			# 这里保持 middle 在中心 (MIDDLE_DEFAULT_X)，因为它只有一个数字
			middle.texture = number_map.get(ones)
			
		# B. 两位数: 10 <= value <= 99
		elif value <= 99:
			# 核心修改：让 left 和 right 靠得更近
			left.position.x = -TIGHT_OFFSET_X   # 移动 left 到更靠近中心的位置 (例如 -50)
			right.position.x = TIGHT_OFFSET_X   # 移动 right 到更靠近中心的位置 (例如 +50)
			
			left.texture = number_map.get(tens)# 十位显示在 left 上
			right.texture = number_map.get(ones)# 个位显示在 right 上
			
		# C. 三位数: 100 <= value <= 999
		elif value <= 999:
			# 保持默认位置 (已在开头重置)
			left.texture = number_map.get(hundreds) # 百位显示在 left 上
			middle.texture = number_map.get(tens)# 十位显示在 middle 上
			right.texture = number_map.get(ones)# 个位显示在 right 上
