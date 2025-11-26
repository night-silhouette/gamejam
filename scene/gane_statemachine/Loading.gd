extends State

var main_game_path:String="res://scene/game/game.tscn"
var	main_game:PackedScene
var lock1=false #资源请求锁
var lock2=false	#动画锁
func enter():
	ResourceLoader.load_threaded_request(main_game_path)
	

func update(_delta: float):
	
	if !lock1 and ResourceLoader.load_threaded_get_status(main_game_path)==ResourceLoader.THREAD_LOAD_LOADED:
		main_game=ResourceLoader.load_threaded_get(main_game_path)
		lock1=true
	if lock2 and lock1:
		finished.emit("main_menu")
		
	
