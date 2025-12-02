extends Node2D
@onready var attack_area: Area2D = $a
@onready var skill_area: Area2D = $b
signal attack
signal skill
@onready var a_no: Sprite2D = $a/ANo
@onready var d_no: Sprite2D = $b/DNo
@export var transform_time=0.6
const A_NO = preload("uid://c6xppnvxp6mw8")
const D_NO = preload("uid://bosso45ikmgq8")
const A = preload("uid://b7j6216oybms8")
const D = preload("uid://clmajnxrha1dq")
var map={"A":[A_NO,A],"D":[D_NO,D]}
var temp1
var temp2
var lock:bool=true

@rpc("any_peer","call_local")
func round_end():
	GameStateMachine.timer.timeout.emit()

func be_pressed(which):
	if lock and GameStateMachine.is_self_round:
		round_end.rpc()
		if which=="A":
			attack.emit()
			a_no.texture=map[which][1]	
			temp1=Util.set_time(transform_time,func():a_no.texture=map[which][0])
			lock=false
		elif which=="D":
			skill.emit()
			d_no.texture=map[which][1]
			temp2=Util.set_time(transform_time,func():d_no.texture=map[which][0])
			lock=false
		
		
	

func _ready() -> void:
	GameStateMachine.on_round_change.connect(func():lock=true)
	

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
	
	
	
