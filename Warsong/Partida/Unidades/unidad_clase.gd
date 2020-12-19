extends Node
class_name Unidad

var clase = {}
var equipo 
var equipamiento = []
var slots = {}
var items = {}
var vida = 0

func _init(tropa, equipo_data):
	self.set_clase(tropa.clase)
	self.set_equipamiento(tropa.equipamiento)
	self.set_equipo(equipo_data)
	self.set_vida()
	
func set_clase(clase_data):
	self.clase = Data.clases_unidades[clase_data]
	for slot in clase.slots:
		self.slots[slot] = {"equipado": false}
	
func set_equipo(equipo_data):
	self.equipo = equipo_data

func set_equipamiento(equipamiento_data):
	for item in equipamiento_data:
		if self.puede_equipar(item):
			self.equipamiento.append(item)

func puede_equipar(item) -> bool:
	var item_data = Data.items[item]
	return clase_pude_equipar_item(item_data) and unidad_dispone_de_slots(item_data)

func clase_pude_equipar_item(item) -> bool:
	return Listas.comparar_arrays(item.clases, self.clase.puede_equipar)

func unidad_dispone_de_slots(item) -> bool:
	# Arrancamos diciendo que puede equiparse el item
	# y buscamos si alguno de los slots que requiere el item esta equipado en esta unidad (self)
	var slots_disponibles = true 
	for slot in item.slots:
		var slot_ocupado = self.slots[slot].equipado
		# si el slot esta ocupado, entonces no permitimos equipar el item
		# se puede hacer con menos variables pero estoy priorizando comprension mas rapida del metodo
		if slot_ocupado: 
			slots_disponibles = false
			break
	return slots_disponibles

func get_movimientos():
	var movimientos = self.clase.movimientos
	return movimientos
	
func set_vida():
	self.vida = self.clase.vida
	
func actualizar_vida(danio : int):
	self.vida = self.vida - danio

func get_ataque():
	return self.clase.ataque

func get_defensa():
	return self.clase.defensa