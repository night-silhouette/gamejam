extends Card
func skill():
	super.skill()
	obj.now_hp=0

func die():
	GameStateMachine.update_prop_enemy("now_hp",0)
