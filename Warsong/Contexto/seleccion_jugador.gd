extends "seleccion_jugador.gd"

var actor_activo = "actor_activo"
var celdas_movimiento = "celdas_movimiento"


func get_actor_activo():
	return self.data_contexto[actor_activo]
	
func set_actor_activo(actor):
	self.data_contexto[actor_activo] = actor
