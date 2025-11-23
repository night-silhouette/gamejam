extends Sprite2D
var mouse_pos
func _process(delta: float) -> void:
	mouse_pos = get_viewport().get_mouse_position()
	global_position=mouse_pos+Vector2(5,15)
