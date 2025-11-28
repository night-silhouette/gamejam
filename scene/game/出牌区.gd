extends Area2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


var has_card:bool=false:
	set(value):
		has_card=value
		if value:
			collision_shape_2d.disabled=true	
		else: 
			collision_shape_2d.disabled=false
			
