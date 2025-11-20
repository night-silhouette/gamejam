extends State_machine

class_name Collision_managment

var main_collision
@export var shape_map:Dictionary[String,RectangleShape2D]

func change_before(next_state_name):
	main_collision.shape=shape_map[next_state_name]
	
@onready var player=get_tree().get_nodes_in_group("player")[0]
func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	
	
	
	
