extends Card

func skill():
	super.skill()
	last_round+=5
	
func skill_last_callback():
	if last_round>0:
		GameStateMachine.update_reduction(-1)
	if last_round==0:
		GameStateMachine.update_reduction(1)
		


	
