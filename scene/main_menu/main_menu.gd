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
	
func _on_peer_connected(id:int):
	print(id)
func _on_client_pressed():
	peer.create_client("127.0.0.1",9999)
	multiplayer.multiplayer_peer=peer
func _ready() -> void: 
	host_button.pressed.connect(_on_host_pressed)
	client_button.pressed.connect(_on_client_pressed)
	
	
	
