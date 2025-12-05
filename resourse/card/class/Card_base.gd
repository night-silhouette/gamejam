extends Resource

class_name Card_base

@export var id:int
@export var card_face:Texture
@export var is_parent_card:bool
@export var is_character:bool
@export var hp:int =0
@export var damage:int =0
@export var special_state:int =0
@export var skill_use_number:int=0
#内部计算属性-----------
var obj:card_on_hard
var lock=true	
var reduction:float=1
var last_round:int=0:
	set(value):
		if value<0:
			last_round=0
			return
		last_round=value
		skill_last_callback()
func skill_last_callback():
	pass

#----------------------
	
	
func attack():

	GameStateMachine.damage(obj.damage)
func skill():
	if !lock:
		return
	if skill_use_number==0:
		return

	
