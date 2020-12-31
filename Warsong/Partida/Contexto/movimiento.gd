extends "contexto_singleton.gd"

var celdas_movimiento = "celdas_movimiento"

func add_dispose_grilla_movimiento(grilla):
	self.agregar_dispose(funcref(grilla, "quitar_celdas_resaltadas"))

func set_celdas_de_movimiento(celdas):
	self.data_contexto[celdas_movimiento] = celdas
		
func si_celda_resaltada(celda):
	for key in self.data_contexto[celdas_movimiento]:
		if celda._eq(key):
			return true