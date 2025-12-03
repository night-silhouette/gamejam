extends Resource

class_name Card_base

@export var id:int
@export var card_face:Texture
@export var is_parent_card:bool
@export var is_character:bool
@export var hp:int =0
@export var damage:int =0
@export var special_state:int =0

var obj:card_on_hard


	
	
func attack():
	print("attack")
	GameStateMachine.damage(obj.damage)
	
func skill():
	pass
