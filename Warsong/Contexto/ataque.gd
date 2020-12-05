extends "contexto_singleton.gd"


var actor_activo = "actor_activo"
var celdas_movimiento = "celdas_movimiento"
var actor_destino = "actor destino"

func calcular_danio(actor_activo : Node2D, actor_destino : Node2D):
	var danio = actor_activo.data()["ataque"] - actor_destino.data()["defensa"]
	return danio

func add_dispose_menu(menu):
	self.agregar_dispose(funcref(menu, "ocultar"))
