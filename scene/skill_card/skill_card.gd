extends Node

var num_list
var lock10=false
var num10=0:
	set(value):
		num10=value
		if lock10:
			if num10==10:
				GameStateMachine.update_prop_self("reduction",0)
				
		
	
	
	
func _ready():
	num_list=[num10]
	GameStateMachine.on_round_change.connect(func():
		for num in num_list:
			num+=1
		)
	
	
	
func skill10():
	lock10=true
	num10=0
	GameStateMachine.update_prop_self("reduction",0)
	
