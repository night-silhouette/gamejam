class_name card_on_hard
extends Control

	
	
@export var transform_speed=900	
@export var hover_transform_time=0.3
	
var half_size = get_rect().size / 2.0
func update_card_to_mouse_center(mouse_position):
	var center_offset = half_size - mouse_position
	global_position-=center_offset



	
	
var is_draged:bool=false
var orignal_position
var orignal_rotation

var hover_lock:bool=true


var start_hover_tween_container=[]
var end_hover_tween_container=[]
func _ready() -> void:
	
	set_process(false)
	mouse_entered.connect(func():
		if hover_lock:
			#hover_lock=false
			for items in end_hover_tween_container:
				items.finished()
			orignal_rotation=rotation
			start_hover_tween_container.push_back(Util.tween_fast_to_slow(self,"rotation",0,hover_transform_time,func():
				hover_lock=true
				start_hover_tween_container=[]))
			start_hover_tween_container.push_back(Util.tween_fast_to_slow(self,"scale",Vector2(1.5,1.5),hover_transform_time))
			start_hover_tween_container.push_back(Util.tween_fast_to_slow(self,"global_position",global_position+Vector2(-40,-40),hover_transform_time))
			)
	mouse_exited.connect(func():
		if hover_lock:
			#hover_lock=false
			
			for items in start_hover_tween_container:
				items.finished()
			end_hover_tween_container.push_back(Util.tween_fast_to_slow(self,"rotation",orignal_rotation,hover_transform_time,func():
				hover_lock=true
				end_hover_tween_container=[]
				))
			end_hover_tween_container.push_back(Util.tween_fast_to_slow(self,"scale",Vector2(1,1),hover_transform_time))
			end_hover_tween_container.push_back(Util.tween_fast_to_slow(self,"global_position",global_position-Vector2(-40,-40),hover_transform_time))
		)


signal reback_start()

var drag_lock:bool=true
func _gui_input(event):
	if drag_lock:
		if event is InputEventMouseButton :
			if event.pressed:
				is_draged=true
				orignal_position=global_position
			else:
				is_draged=false
				drag_lock=false
				Util.tween_fast_to_slow(self,"global_position",orignal_position,global_position.distance_to(orignal_position)/transform_speed,func():drag_lock=true)
				#for items in start_hover_tween_container:
					#items.kill()
				#for items in end_hover_tween_container:
					#items.kill()				
				mouse_exited.emit()
		elif event is InputEventMouseMotion:
			if is_draged:
				update_card_to_mouse_center(event.position)

func init():
	orignal_rotation=rotation
	orignal_position=global_position


func _process(delta: float) -> void:
	if start_hover_tween_container:
		print(start_hover_tween_container)
	
	
