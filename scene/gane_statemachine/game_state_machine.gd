extends State_machine


func _ready() -> void:
	state_map["GameX"]=GameX
	init_state="GameX"
	
