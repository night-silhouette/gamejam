extends Card


func passive_skill():
	GameStateMachine.update_prop_enemy("card_source:lock",false)
	
func die():
	GameStateMachine.update_prop_enemy("card_source:lock",true)
	
