extends Sprite2D



@onready var 牌面: Sprite2D = $牌面

@onready var _hp: Node2D = $hp
@onready var _state: Node2D = $state
@onready var _damage: Node2D = $damage




var state:int=0:
	set(value):
		
		state=value
		_state.value=value


var tex:Texture:
	set(value):
		tex=value
		牌面.texture=value

var hp:int=0:
	set(value):
		hp=value
		_hp.value=value
			

var damage:int=0:
	set(value):
		damage=value
		
		_damage.value=value
