extends Control

@export var has_connect:bool=false

var peer = ENetMultiplayerPeer.new()
@onready var line_edit: LineEdit = $LineEdit
@onready var line_edit_2: LineEdit = $LineEdit2

@onready var host_button=$host
@onready var client_button=$Client
var ip:String
var port=3000

# 检查字符串是否符合 IPv4 地址格式 
func is_ip_address_valid(ip_address: String) -> bool:
	if ip_address.is_empty():
		return false
	var parts = ip_address.split(".", false)
	if parts.size() != 4:
		return false
	for part in parts:
		if not part.is_valid_int():
			return false
		var num = part.to_int()
		if num < 0 or num > 255:
			return false
	return true
func create_server(_port):
	if _port>65535:
		Util.alert("无端口可用")
		return
	var error=peer.create_server(_port)
	if error==ERR_ALREADY_IN_USE:
		create_server(_port+1)
	return	_port
	

func _on_host_pressed():
	host_button.disabled=true
	client_button.disabled=true
	
	port=create_server(port)
	multiplayer.multiplayer_peer = peer
	Util.alert("创建成功，端口号为"+str(port))
	
	multiplayer.peer_connected.connect(_on_peer_connected)

	
@rpc
func update_conect_state():
	has_connect=true
func _on_peer_connected(id:int):#有新的客户端connect
	update_conect_state.rpc()
	MainMenu.on_servers_create()
	
	
func update_ip(new_text):
	if is_ip_address_valid(new_text):
		ip=new_text
		
	else:
		Util.alert("ip格式错误!")
func update_port(new_text):
	port=int(new_text)
func _ready():
	host_button.pressed.connect(_on_host_pressed)
	client_button.pressed.connect(_on_client_pressed)
	
	line_edit.text_submitted.connect(update_ip)
	line_edit_2.text_submitted.connect(update_port)
	

func _on_client_pressed():
	if line_edit.text:
		update_ip(line_edit.text)
	if line_edit_2.text:
		update_port(line_edit_2.text)
	
	if !ip:
		Util.alert("请输入ip")
		return
	else:
		peer.create_client(ip,port)
		multiplayer.multiplayer_peer=peer
		connecting=true
		

var connecting:bool=false
var lock:bool=true		
func _process(delta: float) -> void:
	if connecting and !multiplayer.is_server():
		if has_connect:
			MainMenu.on_client_create()
		elif lock:
			if peer:##清理上一次的连接
				peer.close()
			multiplayer.multiplayer_peer=null
			
			Util.alert("未能找到服务器")
			lock=false

	
	
	
