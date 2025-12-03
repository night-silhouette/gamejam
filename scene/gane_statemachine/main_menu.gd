extends State

func enter():
	get_tree().change_scene_to_file("res://scene/main_menu/main_menu.tscn")
	
	
func on_servers_create():
	
	finished.emit("gamey")

func on_client_create():
	finished.emit("gamey")

var begin_time=10
func exit():
	Util.set_time(begin_time,func():GameStateMachine.round=1)
	
