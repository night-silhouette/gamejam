extends  State
var begin_time=GameStateMachine.round_time
const BLUE_LOADING = preload("uid://cbev1bwkd3bxo")
var main_game_path="res://scene/gamey/gamey.tscn"
var scene
var lock2=true
func enter():
	if lock2:
		var temp=BLUE_LOADING.instantiate()
		get_tree().current_scene.add_child(temp)
		ResourceLoader.load_threaded_request(main_game_path)
		lock2=false

var lock=true
func _process(delta: float) -> void:
	if lock:
		if ResourceLoader.load_threaded_get_status(main_game_path)==ResourceLoader.THREAD_LOAD_LOADED:
			lock=false
			scene=ResourceLoader.load_threaded_get(main_game_path)
		if scene:
			on_loading_ending()
	
	
func on_loading_ending():
	get_tree().change_scene_to_file(main_game_path)
	GameStateMachine._lock=true
	Util.set_time(begin_time,func():
		GameStateMachine.round=1	
	)
	Util.set_time(0.5,func():
		GameStateMachine.set_progress.emit(begin_time,begin_time,true)	
		)




	
	
