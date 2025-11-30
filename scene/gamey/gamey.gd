extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var debug: Button = $Button
const alert = preload("uid://c4mqmqbwf0meh")


func _ready() -> void:
	animation_player.play("ready")
	debug.pressed.connect(func():
		$"回合计数圆盘".round+=1
		)
	




func _process(delta: float) -> void:
	if Input.is_action_just_pressed("转化视角"):
		Gamey.finished.emit("gamex")
