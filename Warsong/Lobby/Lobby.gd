extends Control
const IP = "127.0.0.1"
const DEFAULT_PORT = 44444

# Max number of players
const jugadores_max = 12
# Players dict stored as id:name
var jugadores = {}

#-------------------- SERVIDOR ------------------------------

func _on_BtnCrearServ_pressed():
	print("start servidor")
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self,"_player_disconnected")
	
	var server = NetworkedMultiplayerENet.new()
	server.create_server(DEFAULT_PORT, jugadores_max)
	get_tree().set_network_peer(server)
	pass 


# Callback from SceneTree, called when client connects
func _player_connected(_id):
	print("server: el cliente con id ", _id, " se conecto")

# Callback from SceneTree, called when client disconnects
func _player_disconnected(id):
	if jugadores.has(id):
		jugadores.erase(id)
		rpc("unregister_player", id)
	
	print("Client ", id, " disconnected")

# Player management functions
remote func register_player(jugador_id, nuevo_jugador_nombre):
	if get_tree().is_network_server():
		print("servidor: register_player inicio")
		
		# We get id this way instead of as parameter, to prevent users from pretending to be other users
		var caller_id = get_tree().get_rpc_sender_id()
		print(caller_id)

		# Add him to our list
		jugadores[caller_id] = nuevo_jugador_nombre
			
		# Add everyone to new player:
		for jugador_id in jugadores:
			rpc_id(caller_id, "register_player", jugador_id, jugadores[jugador_id]) # Send each player to new dude
			
		rpc("register_player", caller_id, jugadores[caller_id]) # Send new dude to all players
		# NOTE: this means new player's register gets called twice, but fine as same info sent both times
			
		print("servidor: ", caller_id, " registered as ", nuevo_jugador_nombre)
		print("servidor:", jugadores)
	else:
		jugadores[jugador_id] = nuevo_jugador_nombre
		print("cliente:", jugadores)

	
remote func unregister_player(id):
	if get_tree().is_network_server():
		if jugadores.has(id):
			jugadores.erase(id)
			print("servidor: ", id, " was unregistered")
	else:
		if jugadores.has(id):
			jugadores.erase(id)
			print("cliente: ", id, " was unpuppet")	

#-------------------- FIN SERVIDOR ------------------------------

#-------------------- CLIENTE ------------------------------

func _on_BtnConectar_pressed() -> void:
	
	print("cliente: start")
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("server_disconnected", self, "_server_disconnected")
	print("cliente: desp de registrarse a las seniales")
	self.connect_to_server()

func connect_to_server():
	var cliente = NetworkedMultiplayerENet.new()
	cliente.create_client(IP, DEFAULT_PORT)
	get_tree().set_network_peer(cliente)

func _connected_ok():
	# Register ourselves with the server
	print("cliente: conectado")
	rpc("register_player", get_tree().get_network_unique_id(), "soy el cliente papa")
	
# Callback from SceneTree, called when unabled to connect to server
func _connected_fail():
	get_tree().set_network_peer(null) # Remove peer
	print("Fallo la conexion al servidor")
	
	# Try to connect again, and again, and again...
	self.connect_to_server()

# Callback from SceneTree, called when server disconnect
func _server_disconnected():
	jugadores.clear()
	
	# Try to connect again
	self.connect_to_server()
	
#-------------------- FIN CLIENTE ------------------------------
