extends Node
const alert_scene = preload("uid://c4mqmqbwf0meh")


func alert(_text):
	var _alert=alert_scene.instantiate()
	_alert.text=_text
	get_tree().current_scene.add_child(_alert)
	return _alert
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
	get_tree().create_timer(time).timeout.connect(callback,CONNECT_ONE_SHOT)
	

	
