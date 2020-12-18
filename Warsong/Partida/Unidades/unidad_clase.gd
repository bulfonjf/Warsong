extends Node
class_name Unidad

var clase = {}
var equipo 
var equipamiento = []
var slots = []
var items = {}

func _init(tropa, equipo_data):
	self.set_clase(tropa.clase)
	self.set_equipamiento(tropa.equipamiento)
	self.set_equipo(equipo_data)
	
func set_clase(clase_data):
	self.clase[clase_data] = Data.clases_unidades[clase_data]
	for slot in clase[clase_data].slots:
		slots.append({"slot": slot, "equipado": false})
	
func set_equipo(equipo_data):
	equipo = equipo_data

func set_equipamiento(equipamiento_data):
	for item in equipamiento_data:
		if self.puede_equipar(item):
			equipamiento.append(item)

func puede_equipar(item):
#// WARNING NO TERMINADO
	var puede_equipar = false
	var item_data = Data.items[item]
	
	var clase_local = Data.clases_unidades[self.clase.keys()[0]]
	#if item_data.clases in clase_local[puede_equipar]: 
	if Listas.comparar_arrays(item_data.clases, clase_local.puede_equipar):	
		for item_slot in item_data.slots:
			var diccionario_a_comparar = {"slot": item_slot, "equipado": false}
			#if self.slots.has({"equipado": false, "slot": item_slot }):
			for slot in self.slots:
				if slot.hash() == diccionario_a_comparar.hash():
					puede_equipar = true
					return puede_equipar
				else:
					return false
	return puede_equipar
		


func get_movimientos(nodo):
	var clase_tipo = nodo.unidad.clase.keys()[0]
	var movimientos = clase[clase_tipo].movimientos
	return movimientos

	
	
func vida():
	return clase.vida
	
func actualizar_vida(nodo, danio : int):
	var clase_tipo = nodo.unidad.clase.keys()[0]
	nodo.unidad.clase[clase_tipo].vida = nodo.unidad.clase[clase_tipo].vida - danio
	print(nodo, nodo.unidad.clase[clase_tipo].vida )
	
	
	
