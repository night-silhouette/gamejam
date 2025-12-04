extends Control
@onready var card_face: Sprite2D = $card_face
@onready var area_2d: Area2D = $Area2D

var texture:Texture
var id
signal pressed(id)
func _ready() -> void:
	card_face.texture=texture
	Util.area2d_connect_click(area_2d,func():pressed.emit(id))
		
		
		
		
		
