extends Control

var peer = ENetMultiplayerPeer.new()

@onready var host_button=$host
@onready var client_button=$Client

func _on_host_pressed():
	var error=peer.create_server(9999)
	if error:
		printerr("服务器创建失败，错误码:",error)
		return
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_on_peer_connected)
	MainMenu.on_servers_create()
	
	
	
func _on_peer_connected(id:int):#有新的客户端connect
	print(id)
	
func _on_client_pressed():
	peer.create_client("127.0.0.1",9999)
	multiplayer.multiplayer_peer=peer
	MainMenu.on_client_create()
func _ready() -> void: 
	host_button.pressed.connect(_on_host_pressed)
	client_button.pressed.connect(_on_client_pressed)
	
	
	
