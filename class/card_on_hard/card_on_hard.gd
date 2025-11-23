class_name card_on_hard
extends Control

	
@export_category("特效参数")
@export var transform_speed=1100	
@export var hover_transform_time=0.1
@export var scale_value:Vector2=Vector2(1.5,1.5)	
	
	
@onready var area=$Area
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

var is_on_hard:bool=true:
	set(value):
		is_on_hard=value
		change_is_on_hard.emit()
signal change_is_on_hard()
func _ready() -> void:
	
	pivot_offset=size/2
	set_process(false)
	mouse_entered.connect(func():
		self.z_index=100
		if hover_end_tween and hover_end_tween.is_running():
			hover_end_tween.custom_step(hover_transform_time)
		hover_start_tween=create_tween()
		hover_start_tween.set_ease(Tween.EASE_OUT)
		hover_start_tween.set_trans(Tween.TRANS_CUBIC)	
		hover_start_tween.set_parallel(true)
		hover_start_tween.tween_property(self,"scale",scale_value,hover_transform_time)
		hover_start_tween.tween_property(self,"rotation",0,hover_transform_time)
		
		)
		
	mouse_exited.connect(func():
		self.z_index=original_z_index
		if hover_start_tween and hover_start_tween.is_running():
			hover_start_tween.custom_step(hover_transform_time)
		hover_end_tween=create_tween()
		hover_end_tween.set_ease(Tween.EASE_OUT)
		hover_end_tween.set_trans(Tween.TRANS_CUBIC)	
		hover_end_tween.set_parallel(true)
		hover_end_tween.tween_property(self,"scale",Vector2(1,1),hover_transform_time)
		hover_end_tween.tween_property(self,"rotation",orignal_rotation,0.5*hover_transform_time)

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
				var flag=false
				for item in area.get_overlapping_areas():
					if item.is_in_group("出牌区"):
						flag=true
				if flag:
					is_on_hard=false
				else:
					Util.tween_fast_to_slow(self,"global_position",orignal_position,global_position.distance_to(orignal_position)/transform_speed,func():
						drag_lock=true
						change_is_on_hard.emit()
					)			
					mouse_exited.emit()
				

		elif event is InputEventMouseMotion:
			
			if is_draged:
				update_card_to_mouse_center(event.position)
var original_z_index
func init():
	
	#var center_point: Vector2 = self.size / 2.0
	#self.pivot_offset = center_point
	orignal_rotation=rotation
	orignal_position=global_position
	original_z_index=z_index

func _process(delta: float) -> void:	
	pass

	
	
	
	
	
	
	
	
	
