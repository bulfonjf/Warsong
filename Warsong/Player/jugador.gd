extends KinematicBody2D

onready var orquestador : Node2D = get_node("/root/NodoPrincipal")
onready var data = get_node("/root/NodoPrincipal/GrillaPrincipal/Data").jugadores["fighter"]
onready var id = "Garett_" + str(RandomNumberGenerator.new())
onready var vida = self.data["vida"]
onready var control_vida : Control = load("res://UI/Control_Vida.tscn").instance()

func data():
	return data

func _ready():
	self.add_child(control_vida)
	control_vida.iniciar(self)
	pass # Replace with function body.

#Devuelve el coste de movimiento del jugador en un terreno 
func coste_de_movimiento(tile_name):
	var coste = 1000   #Por defecto el jugador no puede moverse al terreno.
	if self.data["coste_movimiento"].has(tile_name):
		coste = self.data["coste_movimiento"][tile_name]
	return coste

#Funcion que se ejecuta cuando clickean al jugador
func _on_jugador_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && !event.is_pressed():
		orquestador.click_en_jugador(self)
		
func mover(posicion : Pixel):
	self.position = posicion.vector
	self.control_vida.actualizar_posicion()
	
func actualizar_vida(vida : int):
	self.vida = vida
	self.control_vida.actualizar_vida(self)
	
