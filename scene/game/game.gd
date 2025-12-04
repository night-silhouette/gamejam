extends Node2D

@export var fight_card={}
@onready var game: Node2D = $".."

@onready var hard_container: Control = $hard_container
@export var parent_card_list:Array[Resource]
const CARD_ON_HARD = preload("res://scene/card_on_hard/Card_on_hard.tscn")
func create_card(src:Resource)->Control:
	var card = CARD_ON_HARD.instantiate()
	card.card_source=src
	
	return card

var rng = RandomNumberGenerator.new()
var current_seed:int

var id

@export var deal_card:Array[Array]


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var gamey: Node2D = $"../gamey"



func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("查看手牌"):
		hard_container.change_left_hard_state()
		


		
		
var is_first_ready;


@onready var multiplayer_synchronizer: MultiplayerSynchronizer = $MultiplayerSynchronizer
func frist_ready():
	
	if is_first_ready:
		GameStateMachine.parent_card_source=parent_card_list
		init_seed()#初始化随机数
		if multiplayer.is_server():
			deal_card=GameStateMachine.card_in_hard_index
		#根据deal_card和是否为服务器发牌
		if multiplayer.is_server():
			for i in range(11):
				var src:Resource=parent_card_list[deal_card[0][i]]
				GameStateMachine.card_in_hard.push_back(create_card(src))		
		else:
			for i in range(11):
				var src:Resource=parent_card_list[deal_card[1][i]]
				GameStateMachine.card_in_hard.push_back(create_card(src))
		for card in GameStateMachine.card_in_hard:
			hard_container.add_child(card)	
		hard_container.container_init()
		GameStateMachine.skill_card=GameStateMachine.card_in_hard.filter(func(items):
				if !items.is_character:
					return true)
@onready var desk_area2d: Area2D = $侧式桌面/Area2D
	
func init_seed():
	rng.randomize()
	current_seed=rng.seed	
	seed(current_seed)
func _ready() -> void:
	
	is_first_ready=GameStateMachine.is_first_ready
	desk_area2d.input_event.connect(func(obj,event,id):
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				game.change_view()
		)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)#隐藏鼠标
	
	
	
	id = multiplayer.get_unique_id()
	if is_first_ready:
		if !multiplayer.is_server():#分端初始化
			multiplayer_synchronizer.synchronized.connect(func():
				frist_ready()
				,CONNECT_ONE_SHOT)
		else:
			frist_ready()
	else:#平时的逻辑
		for card in GameStateMachine.card_in_hard:
			hard_container.add_child(card)
			hard_container.container_init()

		
	
	animation_player.play("enter")


	
func save_card():
	for card in GameStateMachine.card_in_hard:
		hard_container.remove_child(card)
	
	
	


		

	
	

		
		
