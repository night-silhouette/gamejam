extends Node2D
@onready var attack_area: Area2D = $a
@onready var skill_area: Area2D = $b
signal attack
signal skill
@onready var a_no: Sprite2D = $a/ANo
@onready var d_no: Sprite2D = $b/DNo

const A_NO = preload("uid://c6xppnvxp6mw8")
const D_NO = preload("uid://bosso45ikmgq8")
const A = preload("uid://b7j6216oybms8")
const D = preload("uid://clmajnxrha1dq")
var map={"A":[A_NO,A],"D":[D_NO,D]}
var temp1
var temp2


@rpc("any_peer","call_local")
func round_end():
	GameStateMachine.timer.timeout.emit()

func be_pressed(which):
	if GameStateMachine.can_move and GameStateMachine.is_self_round and GameStateMachine.the_card_witch_fight:
		round_end.rpc()
		if which=="A":
			attack.emit()
			a_no.texture=map[which][1]	
			temp1=Util.set_time(0.6,func():a_no.texture=map[which][0])
			GameStateMachine.can_move=false
			GameStateMachine.the_card_witch_fight.card_source.attack()
			attack_animation()
			be_attack_animation.rpc()
			
		elif which=="D":
			skill.emit()
			d_no.texture=map[which][1]
			temp2=Util.set_time(0.6,func():d_no.texture=map[which][0])
			GameStateMachine.can_move=false
			GameStateMachine.the_card_witch_fight.card_source.skill()
@onready var gamey: Node2D = $".."
@onready var enemy_fight: Sprite2D = $"../enemy_fight"
@onready var self_fight: Sprite2D = $"../self_fight"

const ATTACK = preload("uid://bmoomkc5yexrt")
var enemy_attack_animation_position=Vector2(600,129)
var self_attack_animation_position=Vector2(541,440)
func attack_animation():
	self_fight.be_attack(15)
	Util.set_time(0.1,func():
		var temp=ATTACK.instantiate()
		gamey.add_child(temp)
		temp.position=enemy_attack_animation_position
		enemy_fight.be_attack(30)
		enemy_fight.material.set_shader_parameter("_modulate",Color("red"))
		Util.set_time(0.15,func():enemy_fight.material.set_shader_parameter("_modulate",Color("white")))

			)
@rpc("any_peer")
func be_attack_animation():
	enemy_fight.be_attack(-15)
	Util.set_time(0.1,func():
		var temp=ATTACK.instantiate()
		gamey.add_child(temp)
		temp.position=self_attack_animation_position
		temp.scale.x=-temp.scale.x
		self_fight.be_attack(-30)
		self_fight.material.set_shader_parameter("_modulate",Color("red"))
		Util.set_time(0.15,func():self_fight.material.set_shader_parameter("_modulate",Color("white"))))


func _ready() -> void:
	attack_area.input_event.connect(func(obj,event,id):
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				be_pressed("A"))
				
	skill_area.input_event.connect(func(obj,event,id):
		
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				be_pressed("D"))
					
		
		
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		be_pressed("A")
	if Input.is_action_just_pressed("skill"):
		be_pressed("D")
	
	
	
