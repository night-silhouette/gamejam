extends Node2D

@onready var hard_container: Control = $hard_container
@export var parent_card_list:Array[Resource]
const CARD_ON_HARD = preload("res://scene/card_on_hard/Card_on_hard.tscn")

var rng = RandomNumberGenerator.new()
var current_seed:int

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("查看手牌"):
		hard_container.change_left_hard_state()
		


	
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	rng.randomize()
	current_seed=rng.seed
	seed(current_seed)
