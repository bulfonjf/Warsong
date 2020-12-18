extends Node
class_name Unidad

var clase 
var equipo 
var equipamiento = []
var slots = []
var items = {}

func _init(tropa):
	self.set_clase(tropa.clase)
	self.set_equipo(tropa.equipo)
	self.set_equipamiento(tropa.equipamiento)
	
func set_clase(clase_data):
	self.clase = Data.jugadores[clase_data]
	for slot in clase.slots:
		slots.append({"slot": slot, "equipado": false})
	
func set_equipo(equipo_data):
	equipo = equipo_data

func set_equipamiento(equipamiento_data):
	for item in equipamiento_data:
		if self.puede_equipar(item):
			equipamiento.append(item)

func puede_equipar(item):
// WARNING NO TERMINADO
	var puede_equipar = false
	var item_data = Data.items[item]
	if item_data.clases in Data.clases_unidades[self.clase].puede_equipar: 
		
		for item_slot in item_data.slots:
			if self.slots.has({"slot": item_slot, "equipado": true }}):
				puede_equipar = true
			else
				return false
	return puede_equipar
		


func movimiento():
	return clase.movimiento

func vida():
	return clase.vida
	
func actualizar_vida(danio : int):
	clase.vida = clase.vida -danio
	
