extends Sprite2D

@onready var area_2d: Area2D = $Area2D
signal has_press(str)
var lock=true
func _ready() -> void:

	
	area_2d.input_event.connect(func(obj,event,id):
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and lock:
				be_pressed()
				
		
		)
	
func be_pressed():
	has_press.emit(self.name)
	scale*=1.25
