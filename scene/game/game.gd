extends Node2D

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

@export var deal_card:Array[Array]:
	set(value):
		deal_card=value

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("查看手牌"):
		hard_container.change_left_hard_state()
	if Input.is_action_just_pressed("转化视角"):
		animation_player.play("leave")
		animation_player.animation_finished.connect(func(_t):GameX.finished.emit("gamey"))
		
		
var is_first_ready=true


@onready var multiplayer_synchronizer: MultiplayerSynchronizer = $MultiplayerSynchronizer
func frist_ready():
	if is_first_ready:
		
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
	is_first_ready=false
	
func init_seed():
	rng.randomize()
	current_seed=rng.seed	
	seed(current_seed)
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)#隐藏鼠标
	init_seed()#初始化随机数
	
	
	id = multiplayer.get_unique_id()
	if !multiplayer.is_server():#分端初始化
		multiplayer_synchronizer.synchronized.connect(func():
			frist_ready()
			for card in GameStateMachine.card_in_hard:
				hard_container.add_child(card)	
			hard_container.container_init()
			,CONNECT_ONE_SHOT)
	else:
		frist_ready()
		for card in GameStateMachine.card_in_hard:
			hard_container.add_child(card)	
		hard_container.container_init()
		
	
	animation_player.play("enter")
	
	

	
	
	
	


		

	
	

		
		
