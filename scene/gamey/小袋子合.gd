extends Sprite2D
@export var tranform_time=0.4
@export  var position_map:Dictionary[int,Vector2]={}
var ori_position:Vector2=Vector2(-18,37)
@onready var 石头: Sprite2D = $石头
@onready var 布: Sprite2D = $布
@onready var 剪刀: Sprite2D = $剪刀
const 小袋子_合 = preload("uid://ddfcrqcbtxt7u")
const 小袋子_开 = preload("uid://c6t5qrjx53u8g")


@onready var list=[石头,布,剪刀]
var tween1:Tween
var tween2:Tween
func open():
	self.texture=小袋子_开
	for i in range(list.size()):
		var item:Sprite2D=list[i]	
		item.visible=true
		if tween2 and tween2.is_running():
			tween2.kill()
		tween1=create_tween()
		tween1.set_ease(Tween.EASE_OUT)
		tween1.set_trans(Tween.TRANS_CUBIC)	
		
		tween1.set_parallel(true)
		tween1.tween_property(item,"position",position_map[i],tranform_time)
func back():
	for i in range(list.size()):
		var item:Sprite2D=list[i]	
		if tween1 and tween1.is_running():
			tween1.kill()
		tween2=create_tween()
		tween2.set_ease(Tween.EASE_OUT)
		tween2.set_trans(Tween.TRANS_CUBIC)	
		tween2.set_parallel(true)
		tween2.tween_property(item,"position",ori_position,tranform_time)
		tween2.finished.connect(func():
			self.texture=小袋子_合
			for j in list:
				j.visible=false
			)
var is_open=false


@onready var right_hard: Sprite2D = $"../空右手"
func change_state():
	if !is_open:
		open()
		is_open=true
	else:
		back()
		is_open=false
@onready var area_2d: Area2D = $Area2D
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("查看手牌"):
		change_state()
	
	
func _ready() -> void:
	area_2d.input_event.connect(func(obj,event,id):
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				change_state()
		)
		
		
		
		

	
	
	
	
	
	
	
	
			
