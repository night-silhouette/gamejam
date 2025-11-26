extends Node2D

@onready var hard_container: Control = $hard_container
@export var parent_card_list:Array[Resource]
const CARD_ON_HARD = preload("res://scene/card_on_hard/Card_on_hard.tscn")

var rng = RandomNumberGenerator.new()
var current_seed:int

var id

@export var player_card={}

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("查看手牌"):
		hard_container.change_left_hard_state()
	if Input.is_action_just_pressed("转化视角"):
		animation_player.play("leave")
		animation_player.animation_finished.connect(func(_t):GameX.finished.emit("gamey"))
		
		

func _ready() -> void:
	animation_player.play("enter")
	id = multiplayer.get_unique_id()
	player_card[id]=[]
	
	
	
	
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	rng.randomize()
	current_seed=rng.seed	
	seed(current_seed)
	
	
	
	
	parent_card_list.shuffle()
	for i in range(11):
		var src=parent_card_list[i]
		var card=CARD_ON_HARD.instantiate()
		card.card_source=src
		player_card[id].push_back(card)
		hard_container.add_child(card)
	hard_container.container_init()
	
	
	
	
	
	
	
