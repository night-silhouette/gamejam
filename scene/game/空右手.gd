extends Sprite2D

const hover_right_hard = preload("res://asset/环境素材/侧式/指右手2.0.png")
const right_hard = preload("res://asset/环境素材/侧式/空右手.png")
var mouse_pos
func _process(delta: float) -> void:
	mouse_pos = get_viewport().get_mouse_position()
	global_position=mouse_pos+Vector2(20,30)
	
func change_texture(flag):
	if flag:
		texture=right_hard
	else:
		texture=hover_right_hard

		
	
