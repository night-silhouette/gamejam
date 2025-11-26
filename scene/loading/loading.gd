extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("loading")
	animation_player.animation_finished.connect(func(_t):
		Loading.lock2=true)

	
