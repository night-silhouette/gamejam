extends Control


@export var max_width_percent: float = 0.8
@export var base_y_offset: float = 100.0   
@export var card_spacing: float = 0.5     
@export var card_arc_angle: float = 0.5    
@export var y_bios=20

var card_in_hard=[]
var viewport_x
var viewport_y


func _ready() -> void:
	viewport_x=get_viewport_rect().size.x
	viewport_y=get_viewport_rect().size.y
	card_in_hard=get_children().filter(func(item):return item.is_in_group("card_in_hard"))
	tranform_card()

	$"../Button".pressed.connect(func():tranform_card())
func tranform_card():
	if self.is_node_ready():
		var card_num=card_in_hard.size()
		var px_temp=viewport_x/card_num*max_width_percent
		var r_temp=card_arc_angle/card_num
		
		for i in range(card_num):
			card_in_hard[i].global_position=Vector2(-viewport_x/2*max_width_percent+i*px_temp,viewport_y/2-base_y_offset-y_bios* Util.u_sequence(card_num)[i])
			card_in_hard[i].rotation=Util.zero_cross_sequence(card_num)[i]*r_temp
			card_in_hard[i].z_index=-Util.u_sequence(card_num)[i]




















































































































































		
	
	
