extends Node2D

@onready var button: Button = $Button


#headless servers将不存在client逻辑
func _ready() -> void:
	if OS.has_feature("dedicated_server"):
		queue_free()
		return
	
	button.pressed.connect(func():ClientWebRequest.connect_to_server())


func _process(delta: float) -> void:
	pass
