extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("loading")
	animation_player.animation_finished.connect(func(_t):
		if _t == "loading":
			self.queue_free()
		)
	
	
