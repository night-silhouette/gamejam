extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("ready")
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("转化视角"):
		Gamey.finished.emit("gamex")
