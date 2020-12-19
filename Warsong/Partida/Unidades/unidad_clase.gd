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
	self.clase = Data.clases_unidades[clase_data]
	for slot in clase.slots:
		slots.append({"slot": slot, "equipado": false})
	
func set_equipo(equipo_data):
	equipo = equipo_data

func set_equipamiento(equipamiento_data):
	for item in equipamiento_data:
		if self.puede_equipar(item):
			equipamiento.append(item)

func puede_equipar(item):
	var item_data = Data.items[item]
	return clase_pude_equipar_item(item_data) and unidad_dispone_de_slots(item_data)

func clase_pude_equipar_item(item):
	return item in self.clase.puede_equipar

func unidad_dispone_de_slots(item):
	var disponible = false
	for slot in item.slots:
		disponible = self.slots[slot]
		if !disponible:
			break
	return disponible

func get_movimientos(nodo):
	var clase_tipo = nodo.unidad.clase.keys()[0]
	var movimientos = clase[clase_tipo].movimientos
	return movimientos
	
func vida():
	return clase.vida
	
func actualizar_vida(nodo, danio : int):
	var clase_tipo = nodo.unidad.clase.keys()[0]
	nodo.unidad.clase[clase_tipo].vida = nodo.unidad.clase[clase_tipo].vida - danio