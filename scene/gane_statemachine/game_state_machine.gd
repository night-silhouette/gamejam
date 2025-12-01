extends State_machine
const CARD_ON_HARD = preload("uid://bn84ltnokpuvb")


signal on_round_change

signal set_progress(time,total_time,flag)

var judge_time=5
var judge:String
func judge_first_turn():
	set_progress.emit(judge_time,judge_time,true)
	Util.set_time(judge_time,func():pass
		)
var round:int:
	set(value):
		round=value
		on_round_change.emit()
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
var the_card_witch_fight:
	set(value):
		the_card_witch_fight=value
		update_enemy_card_witch_fight.rpc(value.id)
		self_card_change.emit()
var enemy_card_witch_fight :
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
	
	
	state_map["gamex"]=GameX
	state_map["loading"]=Loading
	state_map["main_menu"]=MainMenu
	state_map["gamey"]=Gamey
	
	init_state="loading"
	
	
	init2()
	
