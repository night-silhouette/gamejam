extends Card
func skill():
	super.skill()
	var _damage=GameStateMachine.enemy_card_witch_fight.damage
	var _now_hp=GameStateMachine.enemy_card_witch_fight.now_hp
	
	GameStateMachine.update_prop_enemy("now_hp",_damage)
	GameStateMachine.update_prop_enemy("damage",_now_hp)
