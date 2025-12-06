extends Node2D
@onready var gamey: Node2D = $gamey
@onready var gamex: Node2D = $gamex

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var now_view=true#x
func change_view():
	if now_view:
		animation_player.play("x_y")
		now_view=!now_view
	else:
		animation_player.play_backwards("x_y")
		now_view=!now_view

@onready var camera_2d: Camera2D = $Camera2D

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("转化视角"):
		change_view()
		
	
func _ready() -> void:
	pass
	
