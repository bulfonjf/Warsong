extends Node
class_name Equipo



var recursos : Dictionary 
var nombre : String
var tropas : Array

func _init(partida_data):
	self.nombre = partida_data.nombre
 
		

func agregar_tropa(tropa, posicion : Vector2):
	var nueva_tropa = load("res://Partida/Unidades/Unidad.tscn").instance()
	nueva_tropa.init(tropa, self.nombre)
	nueva_tropa.position = posicion
	self.add_child(nueva_tropa)
	tropas.append(tropa)
	nueva_tropa.add_to_group("Tropas")
	
	
func _ready():
	pass 

