extends Node2D

var init_position=Vector2(-332,-198)
var final_position=Vector2(-1649,-198)
var span:Vector2=final_position-init_position

@onready var texture_progress_bar: TextureProgressBar = $Control/TextureProgressBar
@onready var timer: Timer = $Timer
@onready var num: Node2D = $num

var total_time:float
var time:float
var flag=false#减少

var ratio
signal	over
var is_use=false
func start(_time,_total_time,_flag):
	timer.start()
	time=_time
	total_time=_total_time
	flag=_flag
	is_use=true
func _ready() -> void:
	GameStateMachine.set_progress.connect(start)
	
	timer.timeout.connect(func():
		if time>=0.05:
			time-=0.05
			#ratio=time/total_time
		else:
			timer.stop()
			over.emit()
			is_use=false
			)

func _process(delta: float) -> void:
	if time:
		num.value=time
	if is_use:
		if flag:
			texture_progress_bar.position=init_position + span*(1-time/total_time)
		else:
			texture_progress_bar.position=final_position - span*(1-time/total_time)
		
	
