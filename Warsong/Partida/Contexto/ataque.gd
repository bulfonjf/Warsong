extends "contexto_singleton.gd"



func calcular_danio(actor_activo : Node2D, actor_destino : Node2D):
	var danio = actor_activo.get_ataque() - actor_destino.get_defensa()
	return danio

func add_dispose_menu(menu):
	self.agregar_dispose(funcref(menu, "ocultar"))
