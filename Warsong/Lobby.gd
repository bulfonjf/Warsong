extends Node2D
onready var VBox_lista_clientes = $panel/vbox_server/vbox_labels_servidor
onready var faccion = load("res://Partida/Facciones/faccion_nodo.gd")


var players = {}
var ip = "127.0.0.1"
var puerto = 4242
var _ignore

func _ready():
	_ignore = get_tree().connect("network_peer_connected", self, "_on_cliente_conectado")
#	_ignore = get_tree().connect("network_peer_disconnected", self,"_player_disconnected")
#	_ignore = get_tree().connect("connected_to_server", self, "_connected_to_server_ok")
#	_ignore = get_tree().connect("connected_to_server", self, "_connected_ok")
	_ignore = get_tree().connect("connection_failed", self, "_connected_fail")
#	_ignore = get_tree().connect("server_disconnected", self, "_server_disconnected")
#	_ignore = get_tree().connect("network_peer_disconnected", self,"unregister_jugador")
	_ignore = get_tree().get_root().get_node("Lobby/panel/vbox_cliente/ip_servidor").connect("updatear_ip", self, "updatear_ip")

func host_server():	
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(4242, 10)
	get_tree().set_network_peer(peer)
	#checks:
	print("Hosting...This is my ID: ", str(get_tree().get_network_unique_id()))
	

func join_server():
	var peer_join = NetworkedMultiplayerENet.new()
	peer_join.create_client(ip, 4242)
	get_tree().set_network_peer(peer_join)	
	#checks:
	print("Joining...This is my ID: ", str(get_tree().get_network_unique_id())) 
	print("conectando a ip: " + ip)
	
func _on_cliente_conectado(cliente_id):
	var label = Label.new()
	label.name = str(cliente_id)
	label.text = "se ha conectado el cliente " + " con id:" + str(cliente_id)
	VBox_lista_clientes.add_child(label);	
	register_player(cliente_id)
	
func _on_cliente_desconectado(cliente_id):
	var nombre_label = str(cliente_id)
	var label = get_tree().get_root().find_node(str(nombre_label) , true, false)
	label.queue_free()
	players.erase(cliente_id)
	
	
func _connected_to_server_ok(): 	
	print("(My eyes only)I connected to the server! This is my ID: ", str(get_tree().get_network_unique_id()))	
	#rpc("register_player", get_tree().get_network_unique_id())
#	if game_started:

remote func register_player(id): 
	print("Everyone sees this.. adding this id to your array! ", id) # everyone sees this
	#the server will see this... better tell this guy who else is already in...
	#if !(id in players):
	players[id] = ""
	
	# Server sends the info of existing players back to the new player
	if get_tree().is_network_server():
		# Send my info to the new player
		rpc_id(id, "register_player", 1) #rpc_id only targets player with specified ID
		
		# Send the info of existing players to the new player from ther server's personal list
		for peer_id in players:
			rpc_id(id, "register_player", peer_id) #rpc_id only targets player with specified ID			
		 
		
	
func _on_boton_conectar_pressed():
	self.join_server()

func updatear_ip(_ip):
	self.ip = _ip

func _on_boton_crear_servidor_pressed():
	self.host_server()

#La llama boton iniciar_partida" 
func _on_boton_iniciar_partida_pressed():
	#for player_id in players.keys():
	rpc_id(0,"iniciar_partida")
	pass

#inicia la partida, alguien apreto el boton iniciar partida al parecer
remotesync func iniciar_partida():
	
	if get_tree().is_network_server(): 
		players[1] = ""	
		var cantidad_de_jugadores = players.size()
		get_node("/root/Lobby").hide()
		var orquestador = load("res://EscenaPrincipal.tscn").instance()	#dont forget to add yourself  server guy!
		orquestador.set_network_master(1)
		orquestador.set_faccion("orcos")
		orquestador.set_cantidad_de_jugadores(cantidad_de_jugadores)
		get_node("/root").add_child(orquestador)
	else:
		var cantidad_de_jugadores = players.size()
		get_node("/root/Lobby").hide()
		var mi_id = get_tree().get_network_unique_id()
		var orquestador = load("res://EscenaPrincipal.tscn").instance()	
		orquestador.set_network_master(mi_id)
		orquestador.set_faccion("elfos")
		orquestador.set_cantidad_de_jugadores(cantidad_de_jugadores)
		get_node("/root").add_child(orquestador)