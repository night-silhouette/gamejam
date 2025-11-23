extends Node2D

func _ready() -> void:
	var tween=create_tween()
	tween.tween_method(print,1.0,0,0.3)
