extends Sprite2D



const _1 = preload("uid://cjrqjvbw1fruy")
const _2 = preload("uid://c60q66h04ad6m")
const _3 = preload("uid://5665qvsvfqe6")
const _4 = preload("uid://cukcgcn6210qc")
const _5 = preload("uid://dhfa0daxoty2f")
const _6 = preload("uid://coal4gmvroyk4")
const _7 = preload("uid://bb5n6e2v7j205")
const _8 = preload("uid://kjsep4yyjb2u")
const _9 = preload("uid://cj2ry54tvhkwm")
const _10 = preload("uid://cxfcaniygen0i")
@onready var _hp: Sprite2D = $hp
@onready var _damage: Sprite2D = $damage
@onready var 牌面: Sprite2D = $牌面
@onready var _state: Sprite2D = $state



var state:int:
	set(value):
		
		state=value
		_state.texture=number_map[value]


var tex:Texture:
	set(value):
		tex=value
		牌面.texture=value

var hp:int:
	set(value):
		hp=value
		_hp.texture=number_map[hp]
			

var damage:int:
	set(value):
		damage=value
		
		_damage.texture=number_map[damage]
var number_map={1:_1,2:_2,3:_3,4:_4,5:_5,6:_6,7:_7,8:_8,9:_9,10:_10,0:null}
