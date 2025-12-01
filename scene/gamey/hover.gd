extends Sprite2D
@onready var right_hard: Sprite2D = $"../../空右手"

@onready var area_2d: Area2D = $Area2D
var is_hover:bool=false
var lock
signal has_press(str)
func _ready() -> void:
	area_2d.mouse_entered.connect(func():
		is_hover=true
		right_hard.change_texture(false))
	area_2d.mouse_exited.connect(func():
		is_hover=false
		right_hard.change_texture(true))
	
	area_2d.input_event.connect(func(obj,event,id):
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and lock:
				has_press.emit(self.name)
				scale*=1.2
		
		)
	
