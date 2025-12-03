extends Sprite2D
@onready var area_2d: Area2D = $Area2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _dead():
	animation_player.play("crush")
	texture=null

signal on_check
var card_source:Card :
	set(value):
		card_source=value
		self.texture=card_source.card_face
		if !is_enemy:
			GameStateMachine.the_card_witch_fight.die.connect(_dead)
		else :
			GameStateMachine.enemy_card_witch_fight.die.connect(func():
				_dead())
			
@export var is_enemy:bool=false
func _ready() -> void:

	
	area_2d.input_event.connect(func(obj,event,id):
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				on_check.emit(card_source.hp,card_source.damage,card_source.card_face,card_source.special_state))
	
	
var is_grow:bool=false	
@export var a:float
func _process(delta: float) -> void:
	material.set_shader_parameter("global_fade",a)
	
	
	var flag=GameStateMachine.is_self_round if !is_enemy else !GameStateMachine.is_self_round
	if 	flag and !is_grow:
		start_pulsing_glow()
		is_grow=true
	if is_grow and !flag:
		end_pulsing_glow()
		is_grow=false
				
			
			
			
			
			
#辉光			
const MIN_INTENSITY = 0.8
const MAX_INTENSITY = 5.0
const PULSE_DURATION = 1.0		
const GLOW_INTENSITY_PATH = "material:shader_parameter/glow_intensity"
var tween:Tween
func start_pulsing_glow():
	tween = create_tween()
	tween.set_loops() 
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, GLOW_INTENSITY_PATH, MIN_INTENSITY, PULSE_DURATION)
	tween.tween_interval(0.2)
	tween.tween_property(self, GLOW_INTENSITY_PATH, MAX_INTENSITY, PULSE_DURATION)
func end_pulsing_glow():
	tween.stop()
	material.set_shader_parameter("glow_intensity",0)
	
	
	
		
