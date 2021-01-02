extends Control

onready var label =$Panel/HBoxContainer/Label
const IP = "127.0.0.1"
const DEFAULT_PORT = 44444
var jugadores = {}


func _ready() -> void:
	print("cliente: start")
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("server_disconnected", self, "_server_disconnected")
	print("cliente: desp de registrarse a las seniales")

func _on_BtnConectar_pressed():
	self.connect_to_server()

func connect_to_server():
	var cliente = NetworkedMultiplayerENet.new()
	cliente.create_client(IP, DEFAULT_PORT)
	get_tree().set_network_peer(cliente)

func _connected_ok():
	# Register ourselves with the server
	print("cliente: conectado")
	rpc_id(1, "register_player", "soy el cliente papa")
	label.text = "alta pupeteada"

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

remote func register_player(nuevo_jugador_id, nuevo_jugador_data):
	jugadores[nuevo_jugador_id] = nuevo_jugador_data
	print("cliente:", jugadores)

remote func unregister_player(jugador_id):
	if jugadores.has(jugador_id):
		jugadores.erase(jugador_id)
		print("Cliente ", jugador_id, " was unpuppet")
		
remote func funcion_prueba():
	print("cliente: funcion prueba exito")
