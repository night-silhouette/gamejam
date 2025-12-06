extends Node

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
	
func skill8():
	lock8=true
	num8=0
	var _hp=GameStateMachine.the_card_witch_fight.now_hp*2
	var _damage=GameStateMachine.the_card_witch_fight.damage*2
	GameStateMachine.update_prop_self("now_hp",_hp)
	GameStateMachine.update_prop_self("damage",_damage)
	
	
func skill10():
	lock10=true
	num10=0
	GameStateMachine.update_prop_self("reduction",0)
	
