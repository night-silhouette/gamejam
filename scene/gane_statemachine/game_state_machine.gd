extends State_machine
var card_in_hard_index:Array[Array]=[[],[]]
var card_in_hard:Array[Control]=[]
var is_first_ready=true


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
	
