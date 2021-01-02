extends Control

# Default game port
const puerto = 44444

# Max number of players
const jugadores_max = 12

# Players dict stored as id:name
var jugadores = {}

func _ready() -> void:
	print("start servidor")
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self,"_player_disconnected")
	
	var server = NetworkedMultiplayerENet.new()
	server.create_server(puerto, jugadores_max)
	get_tree().set_network_peer(server)
	pass 

# Callback from SceneTree, called when client connects
func _player_connected(_id):
	print("server: el cliente con id ", _id, " se conecto")
	rpc_id(_id, "funcion_prueba")


# Callback from SceneTree, called when client disconnects
func _player_disconnected(id):
	if jugadores.has(id):
		jugadores.erase(id)
		#rpc("unregister_player", id)
	
	print("Client ", id, " disconnected")

# Player management functions
remote func register_player(nuevo_jugador_nombre):
	print("servidor: register_player inicio")
	
	# We get id this way instead of as parameter, to prevent users from pretending to be other users
	var caller_id = get_tree().get_rpc_sender_id()
	print(caller_id)
	# Add him to our list
	jugadores[caller_id] = nuevo_jugador_nombre
		
	# Add everyone to new player:
	for jugador_id in jugadores:
		rpc_id(caller_id, "register_player", jugador_id, jugadores[jugador_id]) # Send each player to new dude
		
	#rpc("register_player", caller_id, jugadores[caller_id]) # Send new dude to all players
	# NOTE: this means new player's register gets called twice, but fine as same info sent both times
		
	print("Client ", caller_id, " registered as ", nuevo_jugador_nombre)
	print("servidor:", jugadores)
	
puppetsync func unregister_player(id):
	if jugadores.has(id):
		jugadores.erase(id)
		print("Client ", id, " was unregistered")

remote func funcion_prueba():
	print("servidor: servidor tamb tiene funcion prueba")


