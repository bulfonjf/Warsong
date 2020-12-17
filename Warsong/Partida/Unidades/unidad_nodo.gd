extends KinematicBody2D

onready var orquestador : Node2D = get_node("/root/NodoPrincipal")
onready var id = "Garett_" + str(RandomNumberGenerator.new())
var unidad = load("res://Partida/Unidades/unidad_clase.gd")
onready var control_vida : Control = load("res://UI/Control_Vida.tscn").instance()
#onready var data = preload("res://Partida/Unidades/unidad.gd")

func init(clase, equipo):
	 unidad = unidad.new(clase, equipo)

func _ready():
	self.add_child(control_vida)
	control_vida.iniciar(self)
	pass 
func actualizar_vida(danio : int):
	self.unidad.actualizar_vida(danio)
	self.control_vida.actualizar_vida(self)

#Devuelve el coste de movimiento del jugador en un terreno 
func coste_de_movimiento(tile_name):
	var coste = 1000   #Por defecto el jugador no puede moverse al terreno.
	if self.unidad.clase.coste_movimiento.has(tile_name):
		coste = self.unidad.clase.coste_movimiento[tile_name]
	return coste

#Funcion que se ejecuta cuando clickean al jugador

		
func mover(posicion : Pixel):
	self.position = posicion.vector
	self.control_vida.actualizar_posicion()
	

	


func _on_Tropa_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton && !event.is_pressed():
		orquestador.click_en_tropa(self)
	pass
