class_name card_on_hard
extends Control

	
@export var card_source:Card	
	
@export_category("特效参数")
@export var transform_speed=1100	
@export var hover_transform_time=0.1
@export var scale_value:Vector2=Vector2(1.5,1.5)	
@export var flip_time=0.5
@export var perspective=0.1

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
@onready var card_front = $卡面 
@onready var card_back = $普通卡卡背
var f_card_material : ShaderMaterial
var b_card_material : ShaderMaterial

var is_front:
	set(value):
		is_front=value
		card_front.visible=is_front
		card_back.visible=!is_front
func flip():
		var tween=create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_CUBIC)	
		var call_f=Callable(self,"_update_progress").bind(f_card_material).bind("flip_progress")
		var call_b=Callable(self,"_update_progress").bind(b_card_material).bind("flip_progress")
		var temp=1 if is_front else 0
		if is_front:
			tween.tween_method(call_f,1000*(1-temp),1000*temp,flip_time)
			tween.tween_property(self,"is_front",!is_front,0)		
			tween.tween_method(call_b,1000*temp,1000*(1-temp),flip_time)
		else :
			tween.tween_method(call_b,1000*temp,1000*(1-temp),flip_time)
			tween.tween_property(self,"is_front",!is_front,0)		
			tween.tween_method(call_f,1000*(1-temp),1000*temp,flip_time)
func _update_progress(progress,prop,obj):
	obj.set_shader_parameter(prop, progress/1000.0)
	
var is_flat=true#true是可以flat的意思hhh
func flat():
		var tween=create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_CUBIC)	
		var call_f=Callable(self,"_update_progress").bind(f_card_material).bind("tilt_amount")
		var call_b=Callable(self,"_update_progress").bind(b_card_material).bind("tilt_amount")
		
		if is_flat:
			tween.tween_method(call_f,0,-350,flip_time)
			tween.tween_property(self,"is_flat",!is_flat,0)		
			tween.tween_method(call_b,0,-350,flip_time)
		else :
			tween.tween_method(call_b,-350,0,flip_time)
			tween.tween_property(self,"is_flat",!is_flat,0)		
			tween.tween_method(call_f,-350,0,flip_time)
			
const parent_card_back_texture = preload("res://asset/card_in_hard/普通卡卡背.png")
const child_card_back_texture = preload("res://asset/card_in_hard/对局卡卡背.png")

func _ready() -> void:
	card_front.texture=card_source.card_face
	if card_source.is_parent_card:
		card_back.texture=parent_card_back_texture
	else:
		card_back.texture=child_card_back_texture
	
	
	is_front=true
	f_card_material = card_front.material
	b_card_material = card_back.material
	f_card_material.set_shader_parameter("perspective_strength",perspective)
	b_card_material.set_shader_parameter("perspective_strength",perspective)
	
	
	
	
	
	
	
	
	pivot_offset=size/2
	set_process(false)
	mouse_entered.connect(func():
		$"../../空右手".change_texture(false)
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
		$"../../空右手".change_texture(true)
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
var flip_lock:bool=true
func _gui_input(event):
	#print(event)
	if drag_lock:#拖动逻辑
		if event is InputEventMouseButton :
			if event.button_index==1:#左键逻辑
				if event.pressed:
					is_draged=true
					orignal_position=global_position
					
				
				else:
					is_draged=false
					drag_lock=false
					var flag=false
					for item in area.get_overlapping_areas():
						if item.is_in_group("出牌区"):
							flag=true
							flat()
							drag_lock=true

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
	
	
	if event is InputEventMouseButton and event.button_index==2:			
		if flip_lock:
			flip()
			flip_lock=false
			Util.set_time(2*flip_time,func():flip_lock=true)			
			
			
			
			
var original_z_index
func init():
	
	#var center_point: Vector2 = self.size / 2.0
	#self.pivot_offset = center_point
	orignal_rotation=rotation
	orignal_position=global_position
	original_z_index=z_index



func _process(delta: float) -> void:	
	pass

	
	
	
	
	
	
	
	
	
