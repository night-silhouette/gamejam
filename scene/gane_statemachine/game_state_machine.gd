extends State_machine
const CARD_ON_HARD = preload("uid://bn84ltnokpuvb")


signal on_round_change




var gamey
var can_move:bool=true:
	set(value):
		can_move=value
		if !value:
			print(123)

signal set_progress(time,total_time,flag)
var timer1
var timer2
var timer
var is_first:bool:
	set(value):
		is_first=value
		set_progress.emit(round_time,round_time,value)
		is_self_round=value
		timer1=Util.set_time(round_time,func():
			is_self_round=!value
			set_progress.emit(round_time,round_time,!value)
			
			timer2=Util.set_time(round_time,func():
				
				is_self_round=false
				round+=1
				
				)
			timer=timer2
			)
		timer=timer1 

var is_self_round:bool	:
	set(value):
		is_self_round=value
		if value:
			can_move=true
var round_time=25
var judge_time=1.5
var judge:String
var judge_sustained_number:int=0
var judge_is_win:int:
	set(value):
		judge_is_win=value
		if value==2:
			judge_first_turn()
		if value==0:
			is_first=true
			judge_sustained_number+=1
		if value==1:
			is_first=false
			judge_sustained_number=0
@rpc("any_peer","reliable")
func judge_if_win(_judge):
	
	if !judge:
		await get_tree().create_timer(0.15).timeout
	# ------------------- 自己的选择是剪刀 -------------------
	if judge=="剪刀":
		if _judge=="石头":
			judge_is_win=1 # 输
		if _judge=="布":
			judge_is_win=0 # 赢
		if _judge=="剪刀":
			judge_is_win=2 # 平局

	# ------------------- 自己的选择是石头 -------------------
	if judge=="石头":
		if _judge=="剪刀":
			judge_is_win=0 # 赢
		if _judge=="布":
			judge_is_win=1 # 输
		if _judge=="石头":
			judge_is_win=2 # 平局

	# ------------------- 自己的选择是布 -------------------
	if judge=="布":
		if _judge=="石头":
			judge_is_win=0 # 赢
		if _judge=="剪刀":
			judge_is_win=1 # 输
		if _judge=="布":
			judge_is_win=2 # 平局
	

func judge_first_turn():
	judge=""
	set_progress.emit(judge_time,judge_time,true)
	Util.set_time(judge_time,func():
		if !judge:
			var temp=["剪刀","石头","布"]
			temp.shuffle()
			judge=temp[0]
			judge_if_win.rpc(judge)
				
		)
		
func update_last_round():#更新技能持续回合
	if the_card_witch_fight:
		the_card_witch_fight.card_source.last_round-=1	
	if enemy_card_witch_fight:
		enemy_card_witch_fight.card_source.last_round-=1
var round:int:
	set(value):
		round=value
		update_last_round()
		on_round_change.emit()
		can_move=true
		bag.lock=true
		judge_first_turn()
		
func force_out():
	var list = 	card_in_hard.filter(func(item):
		if item and item.is_character:
			return true)
	list.shuffle()
	list[0]._force_out()
		

func find_card_by_id(id):
	for card in parent_card_source:
		if card.id==id:
			var temp=CARD_ON_HARD.instantiate()
			temp.card_source=card
			return temp

@rpc("any_peer")
func update_enemy_card_witch_fight(id):
	enemy_card_witch_fight=find_card_by_id(id)
	
# 出战对象-------------------------------------------------------------------------------------------------------
var the_card_witch_fight:card_on_hard:
	set(value):
		the_card_witch_fight=value
		update_enemy_card_witch_fight.rpc(value.id)
		self_card_change.emit()
		
		
		
		
var enemy_card_witch_fight:card_on_hard:
	set(value):
		enemy_card_witch_fight=value
		enemy_card_change.emit()
		
# 出战对象-------------------------------------------------------------------------------------------------------

signal self_card_change
signal enemy_card_change

var card_in_hard_index:Array[Array]=[[],[]]
var card_in_hard:Array[card_on_hard]=[]
var skill_card:Array[card_on_hard]
var character_card:Array[card_on_hard]

func update_card():
	Util.cleanup_array(card_in_hard)
	Util.cleanup_array(skill_card)
	Util.cleanup_array(character_card)
	gamey.need_to_update_stuff_list=true
	


var is_first_ready=true


var fight_card={}

var parent_card_source
var child_card_source
var total_card_source
var c_id

func randi_deal_card():
	var temp:Array[int]=[]
	for i in range(23):
		temp.push_back(i)
	temp.shuffle()
	for i in range(11):
		card_in_hard_index[0].push_back(temp[i])
	for i in range(12,23):
		card_in_hard_index[1].push_back(temp[i])

func _ready() -> void:
	if multiplayer.is_server():
		randi_deal_card()
	state_map["main_menu"]=MainMenu
	state_map["gamey"]=Gamey
	init_state="main_menu"
	init2()



@rpc("any_peer","reliable")
func update_hp(value):
	the_card_witch_fight.now_hp-=value
	
	
	
func damage(value):
	update_hp.rpc(value)
	enemy_card_witch_fight.now_hp-=value
	
	
	
var _lock=false
func check_force():
	if !the_card_witch_fight and _lock:
		_lock=false
		Util.set_time(round_time*0.95,func():
			
			if !the_card_witch_fight:
				_lock=true
				force_out()
			)
func _process(delta: float) -> void:
	super._process(delta)
	check_force()

@rpc("any_peer","reliable") 
func _update_reduction(value):
	enemy_card_witch_fight.reduction=value
	
func update_reduction(value):
	_update_reduction.rpc(value)
	the_card_witch_fight.reduction=value
	
	
@rpc("any_peer","reliable")
func _update_prop_self(prop:String,value):
	enemy_card_witch_fight.set(prop,value)
	
func update_prop_self(prop:String,value):
	the_card_witch_fight.set(prop,value)
	_update_prop_self.rpc(prop,value)

@rpc("any_peer","reliable")
func _update_prop_enemy(prop:String,value):
	the_card_witch_fight.set(prop,value)
	
func update_prop_enemy(prop:String,value):
	enemy_card_witch_fight.set(prop,value)
	_update_prop_enemy.rpc(prop,value)
	



func update_skill_card():
	skill_card=card_in_hard.filter(func(items):
		if !items.is_character:
			return true)

	
	
@onready var hard_container: Control
@onready var bag: Control

# skill_need_rpc__________________________________________________

@rpc("any_peer","reliable")
func kill_randi_skill_card():#随机废除手牌
	if !skill_card:
		return
	var temp =skill_card
	temp.shuffle()
	var id=temp[0].id
	temp[0].quene_free()
	temp.remove_at(0)
	skill_card=temp
	hard_container.delete_card(id)
	
@rpc("any_peer","reliable")
func kill_all_skill_card():
	for item in skill_card:
		hard_container.delete_card(item.id)
		item.queue_free()
		Util.cleanup_array(card_in_hard)
	
	skill_card=[]
	bag.stuff_list=skill_card




#_____________________________________________________________________	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
