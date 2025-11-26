extends State_machine


func _ready() -> void:
	state_map["gamex"]=GameX
	state_map["loading"]=Loading
	init_state="loading"
	
	#init1(null)
	init2()
	
