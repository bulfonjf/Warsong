extends Node
class_name Unidad

var clase 
var equipo 

func _init(clase, equipo):
	self.set_clase(clase)
	self.set_equipo(equipo)
	
func set_clase(clase_data):
	clase = Data.jugadores[clase_data]
	
func set_equipo(equipo_data):
	equipo = equipo_data

func movimiento():
	return clase.movimiento

func vida():
	return clase.vida
	
func actualizar_vida(danio : int):
	clase.vida = clase.vida -danio
	
