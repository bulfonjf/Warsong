
extends "contexto_singleton.gd"

var actor_activo = "actor_activo"
var celdas_movimiento = "celdas_movimiento"
var accion_mover_tropa = "mover_tropa"

func get_actor_activo():
	return self.data_contexto[actor_activo]
	
func set_actor_activo(actor):
	self.data_contexto[actor_activo] = actor
	
func add_dispose_menu_mapa(menu_mapa):
	self.agregar_dispose(funcref(menu_mapa, "quitar_info"))

func add_dispose_menu(menu):
	self.agregar_dispose(funcref(menu, "ocultar"))

func add_dispose_grilla_movimiento(grilla):
	self.agregar_dispose(funcref(grilla, "quitar_celdas_resaltadas"))
	
func activar_movimiento():
	self.acciones.append(accion_mover_tropa)

func set_celdas_de_movimiento(celdas):
	self.data_contexto[celdas_movimiento] = celdas

func si_movimiento_activado():
	return self.activo and accion_mover_tropa in self.acciones
		
func si_celda_resaltada(celda):
	for key in self.data_contexto[celdas_movimiento]:
		if celda._eq(key):
			return true