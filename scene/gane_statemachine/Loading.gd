extends State

var need_to_load_path:String="res://scene/game/game.tscn"
var	need_to_load_scene:PackedScene
var lock1=false #资源请求锁
var lock2=false	#动画锁
func enter():
	ResourceLoader.load_threaded_request(need_to_load_path)
	

func update(_delta: float):
	
	if !lock1 and ResourceLoader.load_threaded_get_status(need_to_load_path)==ResourceLoader.THREAD_LOAD_LOADED:
		need_to_load_scene=ResourceLoader.load_threaded_get(need_to_load_path)
		lock1=true
	if lock2 and lock1:
		
		get_tree().change_scene_to_packed(need_to_load_scene)
		finished.emit("gamex")
		
	
