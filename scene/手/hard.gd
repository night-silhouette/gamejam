extends Sprite2D

@onready var hp: Node2D = $状态显示/hp
@onready var damage: Node2D = $状态显示/damage
@onready var special: Node2D = $状态显示/special

@export var flag=true


var obj
func _process(delta: float) -> void:
	obj=GameStateMachine.the_card_witch_fight if flag else GameStateMachine.enemy_card_witch_fight
	if obj:
		hp.value=obj.now_hp if obj.now_hp else 0 
		damage.value=obj.damage if obj.damage else 0
		special.value=obj.special if obj.special else 0
	else:
		hp.value=0
		damage.value=0	
		special.value=0
		
		
