extends Card
func skill():
	super.skill()
	obj.now_hp=0
var has=false
func die():
	if !has:
		has=true
		GameStateMachine.update_prop_enemy("now_hp",0)
