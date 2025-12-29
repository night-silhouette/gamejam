extends Node2D
class_name State

var state_machine:State_machine= null;
var animation_player:AnimationPlayer=null;
var state_time:float=0.0;
var obj:CharacterBody2D=null
var gameInputControl: GameInputControl = null

signal finished(next_state_name)
var is_use=true

func debug():
	print(self.state_machine,self.animation_player,self.state_time,self.obj,self.gameInputControl)


func enter() :
	state_time = 0
	
func exit() :
	pass

func update(_delta: float):
	pass

func physics_process(_delta: float):
	pass
	
func handled_input(_event: InputEvent):
	pass
	


func change_process_state(value: bool):
	set_process(value)
	set_physics_process(value)
	set_process_input(value)
	
func animation_end_finished(next_state):
	animation_player.animation_finished.connect(func(_t):
		finished.emit(next_state),CONNECT_ONE_SHOT)
	
func change_use_all(flag:bool,temp=state_machine):
	for item in temp.get_children():
		if item is State:
			item.is_use=flag
		else:
			change_use_all(flag,item)
		
		
