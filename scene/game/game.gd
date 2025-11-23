extends Node2D

@onready var hard_container: Control = $hard_container

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("查看手牌"):
		hard_container.change_left_hard_state()
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
