extends RefCounted
## 通过changed信号，监听数组数据变化
class_name ObservableArray


## op_type: clear,update,add,remove
signal changed(op_type: String, index: int, value: Variant)
var _data: Array = []


func foreach(callback:Callable):
	for item in _data:
		callback.call(item)#少用，破坏分装，尽量只读

func all():
	return _data

func size() -> int:
	return _data.size()
func clear() -> void:
	_data.clear()
	changed.emit("clear", -1, null)
func get_item(index: int) -> Variant:
	return _data[index]
func set_item(index: int, value: Variant) -> void:
	if index < _data.size():
		_data[index] = value
		changed.emit("update", index, value)
func remove_at(index: int) -> void:
	if index < _data.size():
		var removed_value = _data[index]
		_data.remove_at(index)
		changed.emit("remove", index, removed_value)
func push_back(value: Variant) -> void:
	_data.append(value)
	changed.emit("add", _data.size() - 1, value)	
	
func pop_back() -> Variant:
	var temp = _data.pop_back()
	changed.emit("remove", _data.size(), temp)
	return temp
	
func _init(list:Array=[]) -> void:
	_data=list
	
	
	
		
		
	
