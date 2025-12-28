extends Node



@rpc("any_peer","reliable")
func pop_remind(title:String,text:String):
	var temp:AcceptDialog=AcceptDialog.new()
	get_tree().current_scene.add_child(temp)
	temp.title = title
	temp.dialog_text = text
	temp.popup_centered()
	temp.canceled.connect(func():temp.queue_free())
	temp.confirmed.connect(func():temp.queue_free())




func u_sequence(total:int):#2,1,0,1,2
	var middle=int(total/2)
	var res:Array=[]
	if total%2==0:
		res.append_array(Array(range(middle-1,-1,-1)))
		res.append_array(Array(range(0,middle)))
	else :
		res.append_array(Array(range(middle+1,1,-1)))
		res.append_array(Array(range(1,middle+2)))
		
	return res

func zero_cross_sequence(total):#-1.5，-0.5，0.5，1.5
	var middle=int(total/2)
	var res:Array=[]
	if total%2==0:
		var i=-middle+0.5
		while (i<=middle-0.5):
			res.push_back(i)
			i+=1
		
	else:
		res.append_array(Array(range(-middle,0)))
		res.append_array(Array(range(0,middle+1)))
	return res				
	
		
	
func tween_fast_to_slow(obj,prop,value,time,callback=func():pass):
	var tween=create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)	
	tween.tween_property(obj,prop, value,time)
	tween.finished.connect(callback)
	return tween
	
	
func set_time(time,callback):
	var temp=get_tree().create_timer(time)
	temp.timeout.connect(callback,CONNECT_ONE_SHOT)
	return temp

	


func area2d_connect_click(area2d:Area2D,callback:Callable)->void:
	area2d.input_event.connect(func(obj,event,id):
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				callback.call()
		)
	
func get_viewport_center() -> Vector2:
	var viewport: Viewport = get_viewport()
	var viewport_size: Vector2 = viewport.size
	var center_position: Vector2 = viewport_size / 2.0
	return center_position
	
	
	
func _await_time_until(obj_to_check, max_time: float) -> bool:
	var elapsed_time: float = 0.0

	while !obj_to_check and elapsed_time < max_time:
		await get_tree().process_frame
		elapsed_time += get_process_delta_time() 

	if !obj_to_check:
		return true # 成功找到对象
	else:
		return false # 超时
	
	



func cleanup_array(list):
	for i in range(list.size() - 1, -1, -1):
		var item = list[i]
		if not is_instance_valid(item):
			list.remove_at(i)
	
