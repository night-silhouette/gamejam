extends Card


func attack():
	super.attack()
	skill()

func skill():
	super.skill()
	special_state=GameStateMachine.judge_sustained_number
	if GameStateMachine.judge_sustained_number:
		GameStateMachine.kill_all_skill_card.rpc()
