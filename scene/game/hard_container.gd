extends Control


@export var x_span:float=60
@export var base_y_offset: float = 100.0   
@export var card_arc_angle: float = 0.5    
@export var y_bios=20

var card_in_hard=[]
var viewport_x
var viewport_y
func callback_all(callback,arg_list):
	card_in_hard=get_children().filter(func(item):return item.is_in_group("card_in_hard"))
	for i in card_in_hard:
		var callable=Callable(i,callback)
		callable.callv(arg_list)

func _ready() -> void:
	
	
	
	
	
	viewport_x=get_viewport_rect().size.x
	viewport_y=get_viewport_rect().size.y
	card_in_hard=get_children()
	callback_all("set_process",[true])
	tranform_card()

	callback_all("init",[])
	
	$"../Button".pressed.connect(func():
		tranform_card())
	
	
	for item in card_in_hard:
		item.change_is_on_hard.connect(tranform_card)
func tranform_card():
	card_in_hard=get_children().filter(func(item):return item.is_on_hard )
	if self.is_node_ready():
		var card_num=card_in_hard.size()

		

		var r_temp=card_arc_angle/card_num

		for i in range(card_num):
			

				
			var card_size=card_in_hard[i].size
			var diagonal=Vector2(card_size.x/2,card_size.y/2).length()
			var rota=Util.zero_cross_sequence(card_num)[i]*r_temp
			var pivot_bios=Vector2(diagonal*sin(rota),diagonal*cos(rota))
			card_in_hard[i].rotation=rota
			card_in_hard[i].global_position=pivot_bios+Vector2(Util.zero_cross_sequence(card_num)[i]*x_span,viewport_y/2-base_y_offset-y_bios* Util.u_sequence(card_num)[i])
			
			
			
			












	
