extends Sprite2D

@onready var area_2d: Area2D = $Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Util.area2d_connect_click(area_2d,
	func():
		$"../../start_game/AnimationPlayer".play("RESET")	
		$"../../start_game".visible=true
		$"..".visible=false
	)
