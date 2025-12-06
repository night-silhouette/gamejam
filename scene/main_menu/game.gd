
extends Control

const LOADING = preload("uid://b0fbv2q4dlyu2")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var temp=LOADING.instantiate()
	add_child(temp)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
