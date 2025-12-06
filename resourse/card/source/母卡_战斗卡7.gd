extends Card


func skill():
	GameStateMachine.kill_randi_skill_card.rpc()
	
