extends State

func enter():
	get_tree().change_scene_to_file("res://scene/main_menu/main_menu.tscn")
	
	
func on_servers_create():
	
	finished.emit("gamex")

func on_client_create():
	finished.emit("gamex")
