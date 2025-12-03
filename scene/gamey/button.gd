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
			
		elif which=="D":
			skill.emit()
			d_no.texture=map[which][1]
			temp2=Util.set_time(0.6,func():d_no.texture=map[which][0])
			GameStateMachine.can_move=false
			GameStateMachine.the_card_witch_fight.card_source.skill()
		
	

	
	

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
	
	
	
