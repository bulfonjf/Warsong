extends Node
var faccion_clase = load("res://Partida/Facciones/faccion_clase.gd")
var faccion : Faccion
var nombre_nodo = 1
signal guardar_celda_signal(unidad)

func _init(partida_data):
	self.faccion = faccion_clase.new(partida_data)

remotesync func agregar_unidad(unidad, posicion : Pixel, _id_del_que_llama):
	var nueva_unidad = load("res://Partida/Unidades/Unidad.tscn").instance()
	nueva_unidad.init(unidad, self.faccion.nombre)
	nueva_unidad.position = posicion.vector
	nueva_unidad.name = str(nombre_nodo)
	nombre_nodo += 1 
	nueva_unidad.set_network_master(_id_del_que_llama)
	self.add_child(nueva_unidad)
	self.faccion.agregar_unidad(nueva_unidad)
	nueva_unidad.add_to_group("Unidades")
	nueva_unidad.add_to_group(self.faccion.nombre)
	print("agregando la unidad al grupo:")
	print(self.faccion.nombre)
	emit_signal("guardar_celda_signal", nueva_unidad)
	
func get_faccion():
	return faccion

func _ready():
	pass 

