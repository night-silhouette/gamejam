class_name card_on_hard
extends Control

	
var half_size = get_rect().size / 2.0
func update_card_to_mouse_center(mouse_position):
	var center_offset = half_size - mouse_position
	global_position-=center_offset



	
	
var is_draged:bool=false
var orignal_position


signal reback_start()
var reback_lock:bool=false
func _gui_input(event):
	if event is InputEventMouseButton :
		if event.pressed:
			is_draged=true
			orignal_position=global_position
		else:
			is_draged=false
			global_position=orignal_position
			
	elif event is InputEventMouseMotion:
		if is_draged:
			update_card_to_mouse_center(event.position)
func _ready() -> void:
	reback_start.connect(func():reback_lock=true)
	

func _process(delta: float) -> void:
	pass
	
	
