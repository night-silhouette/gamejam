extends Control

const BAG_STUFF = preload("uid://c4omrcm8dvet3")
@onready var v_box_container: VBoxContainer = $ScrollContainer/VBoxContainer
signal pressed(id)
var stuff_list:Array[card_on_hard]:
	set(value):
		stuff_list=value
		update(value)
func update(card_list):
	var i=0
	var j=0
	var box_list=v_box_container.get_children()
	
	for item in box_list:#清空原来的记录
		var temp = item.get_children()
		for t in temp:
			t.queue_free()
	
	for card in card_list:
		var temp=BAG_STUFF.instantiate()
		temp.id = card.id
		temp.texture=card.card_source.card_face
		box_list[j].add_child(temp)
		temp.pressed.connect(func(id):
				pressed.emit(id))
			
		i+=1
		if i==5 and j<=3:
			i=0
			j+=1
var lock:bool=true
func _ready() -> void:
	pressed.connect(on_pressed)
	
	
func on_pressed(id):
	
	if lock:
		var card=GameStateMachine.skill_card[GameStateMachine.skill_card.find_custom(func(item):return item.id==id)]
		card.card_source.skill()
		card.queue_free()
		Util.set_time(0.1,func():
			Util.cleanup_array(GameStateMachine.card_in_hard)
			Util.cleanup_array(GameStateMachine.skill_card)
			GameStateMachine.update_skill_card()
			stuff_list=GameStateMachine.skill_card
			$"../../gamex/hard_container".delete_card(id)
			)

		
	
	
	
	
	
	
	
	
	
