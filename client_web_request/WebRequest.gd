extends Node
var peer=WebSocketMultiplayerPeer.new()
var servers_ip="ws://120.26.145.68"
var port=443
func _ready() -> void:
	var err=peer.create_client(servers_ip+":"+str(port))
	if err!=OK:
		print("连接失败,错误码："+str(err))
		return
	else:
		print("连接成功")
	multiplayer.multiplayer_peer=peer
