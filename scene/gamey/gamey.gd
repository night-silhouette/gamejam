extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer




@onready var self_fight: Sprite2D = $self_fight
@onready var enemy_fight: Sprite2D = $enemy_fight

@onready var check: Sprite2D = $查看
@onready var blur: Control = $蒙层
@onready var round_start: Node2D = $RoundStart
@onready var round_roll: Sprite2D = $回合计数圆盘


func update_round(round):
	round_start.round=round
	round_roll.round=round

func _ready() -> void:

	
	GameStateMachine.on_round_change.connect(func():update_round(GameStateMachine.round))
	
	self_fight.on_check.connect(on_check)
	enemy_fight.on_check.connect(on_check)
	
	animation_player.play("ready")
	if GameStateMachine.the_card_witch_fight:
		self_fight.visible=true
		self_fight.card_source=GameStateMachine.the_card_witch_fight.card_source
	if GameStateMachine.enemy_card_witch_fight:
		enemy_fight.visible=true
		enemy_fight.card_source=GameStateMachine.enemy_card_witch_fight.card_source
	GameStateMachine.self_card_change.connect(func():
		self_fight.visible=true
		self_fight.card_source=GameStateMachine.the_card_witch_fight.card_source)
	GameStateMachine.enemy_card_change.connect(func():
		enemy_fight.visible=true
		enemy_fight.card_source=GameStateMachine.enemy_card_witch_fight.card_source)
		
		
		
		


@onready var gamex: Node2D = $"../gamex"


@onready var bag: Control = $Bag
var bag_flag=true
var need_to_update_stuff_list=true
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("打开背包") :
		open_bag()
		
func open_bag():
		blur.visible=bag_flag
		bag.visible=bag_flag
		bag_flag=!bag_flag
		if need_to_update_stuff_list:
			bag.stuff_list=GameStateMachine.skill_card
			need_to_update_stuff_list=false





var has_checked=false	
		
func on_check(hp,damage,tex,state):
	if !has_checked:
		blur.visible=true
		check.visible=true
		check.tex=tex
		check.state=state
		check.hp=hp
		check.damage=damage
		has_checked=true
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:#左键
			if has_checked:
				blur.visible=false
				check.visible=false
				has_checked=false
