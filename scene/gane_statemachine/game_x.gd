extends State

func enter():
	get_tree().change_scene_to_packed(Loading.main_game)
	
	

func exit():
	get_tree().current_scene.save_card()
	GameStateMachine.is_first_ready=false
