extends Node
const CARD_ON_HARD = preload("uid://bn84ltnokpuvb")

var num_list


var lock10=false
var lock8=false





var num8=0:
	set(value):
		num8=value
		if lock8:
			if num8==5:
				var _hp=GameStateMachine.the_card_witch_fight.now_hp/2+GameStateMachine.the_card_witch_fight.now_hp%2
				var _damage=GameStateMachine.the_card_witch_fight.damage/2
				GameStateMachine.update_prop_self("now_hp",_hp)
				GameStateMachine.update_prop_self("damage",_damage)
			
var num10=0:
	set(value):
		num10=value
		if lock10:
			if num10==10:
				GameStateMachine.update_prop_self("reduction",0)


		
		
	
	
	
func _ready():
	num_list=[num10]
	GameStateMachine.on_round_change.connect(func():
		for num in num_list:
			num+=1
		)
	
func skill5():
	if GameStateMachine.card_has_died:
		var temp_list=GameStateMachine.card_has_died
		temp_list.shuffle()
		var id=temp_list[0]
		
		var temp:card_on_hard=CARD_ON_HARD.instantiate()
		temp.card_source=GameStateMachine.find_by_id(GameStateMachine.parent_card_source,id)
		GameStateMachine.hard_container.add_card(temp)
		GameStateMachine.card_in_hard.push_back(temp)
		GameStateMachine.character_card.push_back(temp)
		GameStateMachine.update_card()
		
		

var last_died_card_damage
func skill6():
	if GameStateMachine.card_has_died:

		var id=GameStateMachine.card_has_died[GameStateMachine.card_has_died.size()-1]
		var temp:card_on_hard=CARD_ON_HARD.instantiate()
		temp.card_source=GameStateMachine.find_by_id(GameStateMachine.parent_card_source,id)
		temp.damage=last_died_card_damage
		temp.card_source.lock=false
		GameStateMachine.hard_container.add_card(temp)
		GameStateMachine.card_in_hard.push_back(temp)
		GameStateMachine.character_card.push_back(temp)
		GameStateMachine.update_card()

func skill7():
	if GameStateMachine.the_card_witch_fight:
		GameStateMachine.the_card_witch_fight.be_hurt.connect(func(hurt):
			GameStateMachine.damage(hurt)
			,CONNECT_ONE_SHOT)

	
func skill8():
	lock8=true
	num8=0
	var _hp=GameStateMachine.the_card_witch_fight.now_hp*2
	var _damage=GameStateMachine.the_card_witch_fight.damage*2
	GameStateMachine.update_prop_self("now_hp",_hp)
	GameStateMachine.update_prop_self("damage",_damage)
	


func skill9():
	pass

func skill10():
	lock10=true
	num10=0
	GameStateMachine.update_prop_self("reduction",0)
	
