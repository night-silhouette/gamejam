extends Card
var num=0
func skill():
	super.skill()
	if num==3:
		GameStateMachine.update_prop_enemy("now_hp",0)
		return
	
	GameStateMachine.bag.select_from_list(GameStateMachine.character_card)
	GameStateMachine.bag.pressed.connect(func(id):
		var item=GameStateMachine.find_by_id(GameStateMachine.card_in_hard,id)
		item.queue_free()
		GameStateMachine.bag.switch()
		GameStateMachine.update_card()
		GameStateMachine.hard_container.delete_card(id)
		GameStateMachine.bag.other=true
		num+=1
		GameStateMachine.update_prop_self("now_hp",3)
		,CONNECT_ONE_SHOT)
