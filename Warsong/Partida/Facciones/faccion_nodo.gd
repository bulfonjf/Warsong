extends Node
var faccion_clase = load("res://Partida/Facciones/faccion_clase.gd")
onready var orquestador : Node2D = get_node("/root/NodoPrincipal")
var faccion : Faccion


func _init(partida_data):
	self.faccion = faccion_clase.new(partida_data)

func agregar_unidad(unidad, posicion : Pixel):
	var nueva_unidad = load("res://Partida/Unidades/Unidad.tscn").instance()
	nueva_unidad.init(unidad, self.faccion.nombre)
	nueva_unidad.position = posicion.vector
	self.add_child(nueva_unidad)
	self.faccion.agregar_unidad(nueva_unidad)
	nueva_unidad.add_to_group("Unidades")
	nueva_unidad.add_to_group(self.faccion.nombre)
	orquestador.guardar_celda_nodo(nueva_unidad)
	
func get_faccion():
	return faccion

func _ready():
	pass 

