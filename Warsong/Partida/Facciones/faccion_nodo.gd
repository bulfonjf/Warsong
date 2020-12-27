extends Node
var faccion_clase = load("res://Partida/Facciones/faccion_clase.gd")

var faccion : Faccion


func _init(partida_data):
	self.faccion = faccion_clase.new(partida_data)

func agregar_unidad(tropa, posicion : Pixel):
	var nueva_tropa = load("res://Partida/Unidades/Unidad.tscn").instance()
	nueva_tropa.init(tropa, self.faccion.nombre)
	nueva_tropa.position = posicion.vector
	self.add_child(nueva_tropa)
	self.faccion.agregar_unidad(nueva_tropa)
	nueva_tropa.add_to_group("Tropas")
	nueva_tropa.add_to_group(self.faccion.nombre)
	
func _ready():
	pass 

