extends Sprite2D

@onready var one: Node2D = $转盘/one
@onready var two: Node2D = $转盘/two
@onready var three: Node2D = $转盘/three
@onready var four: Node2D = $转盘/four

@onready var list =[one,two,three,four]
@onready var roll_obj: Sprite2D = $转盘

@export var transform_time=0.5


var round:int:
	set(value):
		round=value
		_on_round_change()
var need_to_change=GameStateMachine.round+3
func _ready() -> void:
	for i in range(list.size()):
		var temp=i+round
		list[i].value=temp
	
	

			
var tween:Tween
func _on_round_change():
	list[need_to_change].value=GameStateMachine.round+3
	need_to_change=(need_to_change+1)%4
	
	if tween and tween.is_running():
		tween.custom_step(100)
	tween=create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_parallel(true)
	tween.tween_property(roll_obj,"rotation_degrees",(90+roll_obj.rotation_degrees),transform_time)
