extends Resource

class_name Card_base

@export var id:int
@export var card_face:Texture
@export var is_parent_card:bool
@export var is_character:bool
@export var hp:int =0
@export var damage:int =0
@export var special_state:int =0

var obj


	
	
func attack(value):
	pass
	
func skill():
	pass
