extends Card
var skill_damage=1
var num=0
func skill():
	if num==3:
		GameStateMachine.update_prop_enemy("now_hp",0)
		
	if num==2:
		skill_damage=4
		
	GameStateMachine.damage(skill_damage)
	num+=1
	
