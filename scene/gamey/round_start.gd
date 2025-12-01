extends Node2D
var round:int:
	set(value):
		round=value
		num.value=value
		_show()
@onready var num: Node2D = $三位数
@export var transform_time=0.2
@export var leave_time=1.5
func _ready() -> void:
	num.value=round
func _show():
	var tween=create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self,"modulate:a",255,transform_time)
	Util.set_time(leave_time,leave)
func leave():
	var tween=create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self,"modulate:a",0,transform_time)
