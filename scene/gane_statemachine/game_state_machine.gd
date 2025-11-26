extends State_machine


func _ready() -> void:
	state_map["gamex"]=GameX
	state_map["loading"]=Loading
	state_map["main_menu"]=MainMenu
	init_state="loading"
	
	
	init2()
	
