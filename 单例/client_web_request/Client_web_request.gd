extends Node

#<<<接口函数>>>文档注释--------------------------------------：
# connect_to_server: 尝试连接到服务器，
# 	本地调试更改变量servers_ip="ws://127.0.0.1",
# 	云端服务器ip为servers_ip="ws://120.26.145.68"
# 	包含多次尝试连接的逻辑(默认10次，连接不上每秒尝试一次，直到超时)
# 	第二次调用此函数，会创建新的实例连接到服务器，而不是尝试重连
# on_connection_success和on_server_disconnected信号： 如其名，会在连接成功和断连的时候发出
#-----------------------------------------------------------




signal	on_connection_success
signal	on_server_disconnected
# tcp 连接-------------------------------start
var servers_ip="ws://127.0.0.1"
var tcp_peer
var port=443
var max_connect_num=10
var has_connect_num=0
func connect_to_server():
	multiplayer.connected_to_server.connect(_on_connection_success)
	multiplayer.connection_failed.connect(_on_connection_failed)
	multiplayer.server_disconnected.connect(_on_server_disconnected)
	_try_connect()

func _process(_delta: float) -> void:
	if tcp_peer and tcp_peer.get_connection_status() != MultiplayerPeer.CONNECTION_DISCONNECTED:
		tcp_peer.poll()
func _on_connection_success():
	on_connection_success.emit()

func _on_connection_failed():
	if max_connect_num==has_connect_num:
		print("连接超时，请检查网络")
		return
	await Util.set_time(1,func():pass).timeout
	print("进行第"+has_connect_num+"次重连")
	tcp_peer.close()
	_try_connect()
	
func _on_server_disconnected():
	on_server_disconnected.emit()
func _try_connect():
	tcp_peer=WebSocketMultiplayerPeer.new()
	var err=tcp_peer.create_client(servers_ip+":"+str(port))
	if err!=OK:
		print("连接失败,错误码："+str(err))
		has_connect_num+=1
		return
	else:
		print("连接成功")
		multiplayer.multiplayer_peer=tcp_peer
# tcp 连接-------------------------------end
