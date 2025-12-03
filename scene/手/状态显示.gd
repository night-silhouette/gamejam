extends Sprite2D
@onready var area_2d: Area2D = $Area2D
@onready var hard: Sprite2D = $".."

@onready var blur: Control = $"../../蒙层"
var init_position
func _ready() -> void:
	Util.area2d_connect_click(area_2d,check)
	init_position=global_position
var flag:bool=false
func check():
	if !flag:
		self.scale=scale*1.8
		z_index=1000
		blur.visible=true
		flag=!flag
		if !hard.flag:
			rotation+=PI
		


func close():
		blur.visible=false
		self.scale=scale/1.8
		z_index=0
		flag=!flag
		if !hard.flag:
			rotation-=PI

func _input(event: InputEvent) -> void:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				if flag:
					close()
			
			
			
			
			
			
			
			
