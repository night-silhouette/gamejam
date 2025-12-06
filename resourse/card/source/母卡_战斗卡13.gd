extends Card


func attack():
	super.attack()
	last_round+=1
	var _damage=obj.damage
	_damage*=2
	GameStateMachine.update_prop_self("damage",_damage)
	
func skill_last_callback():
	if last_round!=0:
		GameStateMachine.update_reduction(0)
	else:
		GameStateMachine.update_reduction(1)
		
func skill():
	super.attack()
	attack()
