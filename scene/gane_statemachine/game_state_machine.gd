extends State_machine
const CARD_ON_HARD = preload("uid://bn84ltnokpuvb")


signal on_round_change

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
var judge_time=3
var judge:String
var judge_is_win:int:
	set(value):
		judge_is_win=value
		if value==2:
			judge_first_turn()
		if value==0:
			is_first=true
		if value==1:
			is_first=false
@rpc("any_peer","reliable")
func judge_if_win(_judge):
	
	if !judge:
		await get_tree().create_timer(0.2).timeout
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
var round:int:
	set(value):
		round=value
		on_round_change.emit()
		can_move=true
		judge_first_turn()
		
		
		
		

func find_card_by_id(id):
	for card in parent_card_source:
		if card.id==id:
			var temp=CARD_ON_HARD.instantiate()
			temp.card_source=card
			return temp

@rpc("any_peer")
func update_enemy_card_witch_fight(id):
	enemy_card_witch_fight=find_card_by_id(id)
var the_card_witch_fight:card_on_hard:
	set(value):
		the_card_witch_fight=value
		update_enemy_card_witch_fight.rpc(value.id)
		self_card_change.emit()
var enemy_card_witch_fight:card_on_hard:
	set(value):
		enemy_card_witch_fight=value
		enemy_card_change.emit()
signal self_card_change
signal enemy_card_change

var card_in_hard_index:Array[Array]=[[],[]]
var card_in_hard:Array[Control]=[]
var is_first_ready=true


var fight_card={}

var parent_card_source
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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
