extends Node2D
@onready var gamey: Node2D = $gamey
@onready var gamex: Node2D = $gamex

@onready var animation_player_x: AnimationPlayer = $gamex/AnimationPlayer
@onready var animation_player_y: AnimationPlayer = $gamey/AnimationPlayer

func change_view():
	if scene_now:
		animation_player_x.play("leave")
		animation_player_x.animation_finished.connect(func(_t):
			change_visible()
			animation_player_y.play("ready"),CONNECT_ONE_SHOT)
	else :
		change_visible()
		animation_player_x.play("enter")
	
func change_visible():
	scene_now=!scene_now
	gamex.visible=scene_now
	gamey.visible=!scene_now
	
var scene_now=true #gamex
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("转化视角"):
		change_view()
		
	
func _ready() -> void:
	gamex.visible=true
	gamey.visible=false
	
