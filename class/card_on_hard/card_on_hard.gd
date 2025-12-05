class_name card_on_hard
extends Control

var texture
var id 
@export var card_source:Card:
	set(value):
		card_source=value
		card_source.obj=self
		is_character=card_source.is_character
		damage=card_source.damage
		now_hp=card_source.hp
		special=card_source.special_state
		id = card_source.id
		texture=card_source.card_face
		reduction=card_source.reduction
@export_category("特效参数")
@export var transform_speed=1100	
@export var hover_transform_time=0.1
@export var scale_value:Vector2=Vector2(1.5,1.5)	
@export var flip_time=0.5
@export var perspective=0.1
@export var flat_time=0.25
@export var flat_count=350

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



#战斗相关-------------------------------------------------
var reduction=1
var is_on_hard:bool=true:
	set(value):
		is_on_hard=value
		drag_lock=false
		if !value:
			GameStateMachine.the_card_witch_fight=self
			
		change_is_on_hard.emit()	
		
var damage
var in_skill:bool=false	
signal die
var now_hp:float:
	set(value):
		
		var hurt=now_hp-value
		now_hp=now_hp-hurt*reduction
		
		if now_hp<0:#0修正
			now_hp=0
		if now_hp==0 and is_character:#死亡逻辑
			die.emit()

			self.queue_free()
var special
	
var is_character:bool	
		
		
		
#战斗相关-------------------------------------------------
		
		
		
	
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
var flat_tween:Tween
func flat():
	if flat_tween and flat_tween.is_running():
		flat_tween.custom_step(100)
	flat_tween=create_tween()
	flat_tween.set_ease(Tween.EASE_OUT)
	flat_tween.set_trans(Tween.TRANS_CUBIC)	
	var call_f=Callable(self,"_update_progress").bind(f_card_material).bind("tilt_amount")
	var call_b=Callable(self,"_update_progress").bind(b_card_material).bind("tilt_amount")
	
	if is_flat:
		flat_tween.tween_method(call_f,0,-flat_count,flat_time)
		flat_tween.tween_property(self,"is_flat",!is_flat,0)		
		flat_tween.tween_method(call_b,0,-flat_count,flat_time)
	else :
		flat_tween.tween_method(call_b,-flat_count,0,flat_time)
		flat_tween.tween_property(self,"is_flat",!is_flat,0)		
		flat_tween.tween_method(call_f,-flat_count,0,flat_time)

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
		var object_rotation=orignal_rotation if is_on_hard else Vector2(0,0)
		
		hover_end_tween.tween_property(self,"rotation",object_rotation,0.5*hover_transform_time)

		)



var drag_lock:bool=true
var flip_lock:bool=true
var which_card_area:Area2D

signal on_check(hp,damage,tex,state)
func _gui_input(event):
	if event.is_action_pressed("查看"):
		on_check.emit(card_source.hp,card_source.damage,card_source.card_face,card_source.special_state)
	
	#print(event)
	if drag_lock:#拖动逻辑
		if event is InputEventMouseButton :
			if event.button_index==1:#左键逻辑
				if event.pressed:
					is_draged=true
					orignal_position=global_position
					if !is_flat : flat()
					if !is_on_hard:
						reset_card_area()
						is_draged=false
						is_on_hard=true
				elif is_draged:#松手的时候
					is_draged=false
					
					var is_has_out=false
					if is_character:#战斗牌才可出牌
						for item in area.get_overlapping_areas():#检测是否出牌了
							if item.is_in_group("出牌区"):
								is_on_hard=false
								is_has_out=true
								item.has_card=true
								which_card_area=item
								break
					
					if is_has_out:
						flat()
					else:
						reset_card_area()
						is_on_hard=true
						#change_is_on_hard.emit()	
					mouse_exited.emit()		
				
		elif event is InputEventMouseMotion:
			
			if is_draged:
				update_card_to_mouse_center(event.position)
	
	
	if event is InputEventMouseButton and event.button_index==2:			
		if flip_lock:
			flip()
			flip_lock=false
			Util.set_time(2*flip_time,func():flip_lock=true)			
			
			
func reset_card_area():
	if 	which_card_area:
		which_card_area.has_card=false
		which_card_area=null	
			
var original_z_index
func init():
	
	#var center_point: Vector2 = self.size / 2.0
	#self.pivot_offset = center_point
	orignal_rotation=rotation
	orignal_position=global_position
	original_z_index=z_index



func _force_out():
	is_on_hard=false
	flat()
	global_position=Vector2(430,350)
	rotation=0	

	
	
	
	
	
	
	
	
	
