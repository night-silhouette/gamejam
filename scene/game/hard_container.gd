extends Control


@export var x_span:float=60
@export var base_y_offset: float = 100.0   
@export var card_arc_angle: float = 0.5    
@export var y_bios=20
@export var transform_time=0.3
var card_in_hard=[]
var viewport_x
var viewport_y
func callback_all(callback,arg_list):
	card_in_hard=get_children().filter(func(item):return item.is_in_group("card_in_hard"))
	for i in card_in_hard:
		var callable=Callable(i,callback)
		callable.callv(arg_list)

var reback_flag=true
var left_hard_has=preload("res://asset/环境素材/侧式/有牌左手.png")	
var left_hard_not_has=preload("res://asset/环境素材/侧式/空左手.png")	
func change_left_hard_state():
	if reback_flag:
		if transform_tween and transform_tween.is_running():
			transform_tween.custom_step(100)
		reback()
		$"../牌堆".icon=left_hard_has
		reback_flag=false
	else:
		$"../牌堆".icon=left_hard_not_has
		if reback_tween and reback_tween.is_running():
			reback_tween.custom_step(100)
		tranform_card()
		reback_flag=true
			
			
			
func container_init():		
	viewport_x=get_viewport_rect().size.x
	viewport_y=get_viewport_rect().size.y
	card_in_hard=get_children()
	callback_all("set_process",[true])
	tranform_card()
	callback_all("init",[])
	for item in card_in_hard:
		item.change_is_on_hard.connect(tranform_card)
		item.on_check.connect(on_check)
func _ready() -> void:
	
	
	$"../牌堆".pressed.connect(change_left_hard_state)
	
	



var transform_tween:Tween
func tranform_card():
	card_in_hard=get_children().filter(func(item):return item.is_on_hard )
	if self.is_node_ready():
		var card_num=card_in_hard.size()
		var r_temp=card_arc_angle/card_num
		
		transform_tween=create_tween()
		transform_tween.set_ease(Tween.EASE_OUT)
		transform_tween.set_trans(Tween.TRANS_CUBIC)	
		transform_tween.set_parallel(true)
		for i in range(card_num):
			card_in_hard[i].drag_lock=false
			if !card_in_hard[i].visible:
				card_in_hard[i].visible=true

			var card_size=card_in_hard[i].size
			var diagonal=Vector2(card_size.x/2,card_size.y/2).length()
			var rota=Util.zero_cross_sequence(card_num)[i]*r_temp
			var pivot_bios=Vector2(diagonal*sin(rota),diagonal*cos(rota))
			card_in_hard[i].rotation=rota
			var object_position=pivot_bios+Vector2(Util.zero_cross_sequence(card_num)[i]*x_span+viewport_x/2.15,viewport_y/2-base_y_offset-y_bios* Util.u_sequence(card_num)[i])
			transform_tween.tween_property(card_in_hard[i],"global_position",object_position,transform_time)
			card_in_hard[i].z_index=5*i
			transform_tween.finished.connect(func():
				for j in card_in_hard:
					j.drag_lock=true
					)
var reback_tween:Tween		


func reback():
		
		reback_tween=create_tween()
		reback_tween.set_ease(Tween.EASE_OUT)
		reback_tween.set_trans(Tween.TRANS_CUBIC)	
		reback_tween.set_parallel(true)
		var back_position=Vector2(90,480)	
		card_in_hard=get_children().filter(func(item):return item.is_on_hard )
		for items in card_in_hard:
			items.rotation=0
			reback_tween.tween_property(items,"global_position",back_position,transform_time)
			reback_tween.finished.connect(func():items.visible=false)
			
@onready var blur: Control = $"../蒙层"
@onready var check: Sprite2D = $"../查看"
			
var has_checked=false			
func on_check():
	if !has_checked:
		blur.visible=true
		check.visible=true
		check.hp=10
		check.damage=4
	











	
