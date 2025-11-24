extends Sprite2D

const hover_right_hard = preload("res://asset/环境素材/指右手.png")
const right_hard = preload("res://asset/环境素材/空右手.png")
var mouse_pos
func _process(delta: float) -> void:
	mouse_pos = get_viewport().get_mouse_position()
	global_position=mouse_pos+Vector2(5,15)
	
func change_texture(flag):
	if flag:
		texture=right_hard
	else:
		texture=hover_right_hard
	
	
