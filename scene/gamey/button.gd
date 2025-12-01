extends Node2D
@onready var attack_area: Area2D = $a
@onready var skill_area: Area2D = $b
signal attack
signal skill

func _ready() -> void:
		attack_area.input_event.connect(func(obj,event,id):
			if event.is_action_pressed("attack"):
				attack.emit()
			
			if event is InputEventMouseButton:
				if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
					attack.emit())
		skill_area.input_event.connect(func(obj,event,id):
			if event.is_action_pressed("skill"):
				skill.emit()
			if event is InputEventMouseButton:
				if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
					skill.emit())		
					
		
