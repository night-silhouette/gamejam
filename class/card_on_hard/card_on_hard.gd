class_name card_on_hard
extends Control

	
	
@export var transform_speed=1100	
@export var hover_transform_time=0.1
	
var half_size = get_rect().size / 2.0
func update_card_to_mouse_center(mouse_position):
	var center_offset = half_size - mouse_position
	global_position-=center_offset



	
	
var is_draged:bool=false
var orignal_position
var orignal_rotation

var hover_lock:bool=true

var hover_start_tween
var hover_end_tween
func _ready() -> void:
	
	pivot_offset=size/2
	set_process(false)
	mouse_entered.connect(func():
		
		hover_start_tween=create_tween()
		hover_start_tween.set_ease(Tween.EASE_OUT)
		hover_start_tween.set_trans(Tween.TRANS_CUBIC)	
		hover_start_tween.set_parallel(true)
		hover_start_tween.tween_property(self,"scale",Vector2(1.5,1.5),hover_transform_time)
		hover_start_tween.tween_property(self,"rotation",0,hover_transform_time)
		
		)
		
	mouse_exited.connect(func():
		hover_end_tween=create_tween()
		hover_end_tween.set_ease(Tween.EASE_OUT)
		hover_end_tween.set_trans(Tween.TRANS_CUBIC)	
		hover_end_tween.set_parallel(true)
		hover_end_tween.tween_property(self,"scale",Vector2(1,1),hover_transform_time)
		hover_end_tween.tween_property(self,"rotation",orignal_rotation,2*hover_transform_time)

		)


signal reback_start()

var drag_lock:bool=true
func _gui_input(event):
	if drag_lock:
		if event is InputEventMouseButton :
			if event.pressed:
				is_draged=true
				
			
			else:
				is_draged=false
				drag_lock=false
				Util.tween_fast_to_slow(self,"global_position",orignal_position,global_position.distance_to(orignal_position)/transform_speed,func():
					drag_lock=true)			
				mouse_exited.emit()
		elif event is InputEventMouseMotion:
			
			if is_draged:
				update_card_to_mouse_center(event.position)

func init():
	
	#var center_point: Vector2 = self.size / 2.0
	#self.pivot_offset = center_point
	orignal_rotation=rotation
	orignal_position=global_position


func _process(delta: float) -> void:	
	pass
	
	
