extends Resource

class_name Card_base

@export var id:int
@export var card_face:Texture
@export var is_parent_card:bool=false
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
		if last_round==0:
			obj.in_skill=false
		skill_last_callback()

		
		
#----------------------


func skill_last_callback():
	pass
signal _dis
func set_round_callback(round:int,callback:Callable):#我说这个函数设计是人类智商之巅峰（狗头）
	var i=0
	var update_i=func():
		i+=1
		if i == round:
			callback.call()
			_dis.emit()
	GameStateMachine.on_round_change.connect(update_i)
	_dis.connect(func():GameStateMachine.on_round_change.disconnect(update_i),CONNECT_ONE_SHOT)
	

	
func passive_skill():
	pass
	
	
func attack():

	GameStateMachine.damage(obj.damage)
	
var can_use_skill:bool=lock and skill_use_number>0
func skill():
	can_use_skill=lock and skill_use_number>0
	if !can_use_skill:
		return
	var temp=skill_use_number-1
	GameStateMachine.update_prop_self("card_source:skill_use_number",temp)
	obj.in_skill=true
	
func die():
	pass
	
	
	
