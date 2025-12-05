extends Node2D
var i=1:
	set(value):
		if value>1:
			i=0
		elif value<0:
			i=1
		else:
			i=value
var rotation_list=[20,-24]
var position_list=[Vector2(820,520),Vector2(880,122)]
var rotation_list2=[117.4,51.8]
@onready var 箭头: Sprite2D = $箭头
@onready var 小标志: Sprite2D = $小标志
var tween

@onready var _exit: Area2D = $exit
@onready var _enter: Area2D = $enter


func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("up"):
		i+=1
		transform()

	if Input.is_action_just_pressed("dwon"):
		i-=1
		transform()
		
	if Input.is_action_just_pressed("confirm"):
		
		if i==1:#enter
			enter()
		elif i==0:
			print(1)
			get_tree().quit(0)
	
func transform():
		tween=create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_CUBIC)	
		tween.set_parallel(true)
		tween.tween_property(箭头,"rotation_degrees",rotation_list[i],0.4)
		tween.tween_property(小标志,"rotation_degrees",rotation_list2[i],0.4)
		tween.tween_property(小标志,"position",position_list[i],0.4)

func enter():
	self.visible=false
	$"../start_game".visible=true
	
func _ready() -> void:
	Util.area2d_connect_click(_exit,func():get_tree().quit(0))
	Util.area2d_connect_click(_enter,enter)
