extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
signal has_stop
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func play():
	animation_player.play("switch")
	animation_player.animation_finished.connect(
		
		func(_t):
			print(1)
			has_stop.emit())
	
	
