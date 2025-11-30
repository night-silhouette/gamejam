extends Sprite2D
@onready var area_2d: Area2D = $Area2D

signal on_check
var card_source:Card :
	set(value):
		card_source=value
		self.texture=card_source.card_face
func _ready() -> void:
	area_2d.input_event.connect(func(obj,event,id):
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				on_check.emit(card_source.hp,card_source.damage,card_source.card_face,card_source.special_state))
	
				
				
