extends State

func enter():
	get_tree().change_scene_to_packed(Loading.main_game)
