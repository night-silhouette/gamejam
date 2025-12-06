extends Sprite2D
@onready var game: Node2D = $"../.."

const hover_right_hard = preload("res://asset/环境素材/侧式/指右手2.0.png")
const right_hard = preload("res://asset/环境素材/侧式/指右手2.0.png")
var mouse_pos
var flag
func _process(delta: float) -> void:
	flag=game.now_view
	mouse_pos = get_viewport().get_mouse_position()
	var bios:Vector2=Vector2(0,2890) if !flag else Vector2(0,0)
	global_position=mouse_pos+Vector2(20,30)-bios
	
func change_texture(flag):
	if flag:
		texture=right_hard
	else:
		texture=hover_right_hard

		
	
