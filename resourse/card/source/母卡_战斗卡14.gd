extends Card
var skill_lock=false
func attack():
	super.attack()
	if skill_lock:
		var _now_hp=obj.now_hp
		GameStateMachine.update_prop_self("now_hp",_now_hp+2)
	
	skill_lock=true
