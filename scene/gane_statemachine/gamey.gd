extends  State
var begin_time=GameStateMachine.round_time

func enter():
	get_tree().change_scene_to_file("res://scene/gamey/gamey.tscn")
	GameStateMachine._lock=true
	Util.set_time(begin_time,func():
		GameStateMachine.round=1
		
	
	)
	Util.set_time(0.5,func():
		GameStateMachine.set_progress.emit(begin_time,begin_time,true)	
		)
	
	
	
	


	
	
