extends Card


func skill():
	super.skill()
	last_round=1
	set_round_callback(2,func():skill_use_number+=1)
func skill_last_callback():
	if last_round>0:
		GameStateMachine.update_reduction(0)

	else:
		GameStateMachine.update_reduction(1)
