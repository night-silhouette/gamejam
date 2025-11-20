class_name State_machine extends Node
signal state_changed(prev_state, current_state)
@export var init_state:String
var obj: CharacterBody2D
var state_map:Dictionary = {}
var current_state:State 
var prev_state:State

var cur_state_name;#远程调试方便
var gameInputControl:GameInputControl;
@export var is_debug:bool=false
##state_machine的初始化函数
##[br]
##[param obj]:CharacterBody2D[br]
##[param animation_player]:AnimationPlayer[br]
##[param gameInputControl]:GameInputControl[br]
func init(obj: CharacterBody2D, animation_player:AnimationPlayer=null, gameInputControl: GameInputControl = null) -> void:
	if is_debug:	
		state_changed.connect(func(pre,cur):
			print("%s->%s"%[pre.name,cur.name]))
	self.obj = obj
	self.gameInputControl=gameInputControl
	if gameInputControl:
		gameInputControl.obj=obj
	set_all_children_init(get_children(), obj, animation_player,gameInputControl)
	
	var start_state = state_map.get(init_state.to_lower())
	if(start_state):
		start_state.enter()
		current_state = start_state
	
func set_all_children_init(children, parent: CharacterBody2D, animation_player:AnimationPlayer, gameInputControl: GameInputControl) -> void:
	for child in children:
		if child is State:

			child.obj = parent
			child.state_machine = self
			child.animation_player = animation_player
			child.gameInputControl =  gameInputControl
			
			child.finished.connect(func(next_state_name):
				change_state(next_state_name))
			state_map.set(child.name.to_lower(), child)
		elif child.get_child_count() > 0:
			set_all_children_init(child.get_children(), parent, animation_player,gameInputControl)
func insert_with_exit_enter():
	pass


func change_before(next_state_name):
	pass
func change_state(next_state_name:String):
	var next_state = state_map.get(next_state_name.to_lower(),null)
	if next_state_name==cur_state_name:
		return;
	if (!next_state.is_use):
		return
	if(!next_state):
		return
		
		
		
		
	change_before(next_state_name)

	if(current_state):
		current_state.exit()
		prev_state = current_state
	insert_with_exit_enter()
	next_state.enter()
	current_state = next_state
	cur_state_name=current_state.name
	state_changed.emit(prev_state, current_state)
func phy_middleware():
	pass
func middleware():
	pass
func _process(delta: float) -> void:
	middleware()
	if current_state:
		current_state.update(delta)
func _physics_process(delta: float) -> void:
	phy_middleware()
	if current_state:
		current_state.physics_process(delta)
func _unhandled_input(event: InputEvent) -> void:
	if current_state:
		current_state.handled_input(event)
