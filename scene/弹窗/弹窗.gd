extends Node2D
@onready var close: Area2D = $close
@onready var label: Label = $Label
@onready var blur: Control = $蒙层

var text:String

var viewport_size: Vector2
var center_position: Vector2

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("home"):
		leave()
	

func _ready():
	$Label.text=text
	viewport_size= get_viewport_rect().size
	center_position = viewport_size / 2.0
	global_position=center_position
	blur.visible=true
	close.input_event.connect(func(obj,event,id):
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				leave()
		)
signal has_leave
func leave():
	has_leave.emit()
	blur.visible=false
	var tween=create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)	
	tween.tween_property(self,"global_position",Vector2(center_position.x,1000),1)
	tween.finished.connect(queue_free)
