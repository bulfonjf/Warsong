extends Node2D

onready var grilla_principal: TileMap = get_node("/root/NodoPrincipal/GrillaPrincipal")




#
func _ready():
	pass 

func obtener_celdas_donde_se_puede_mover(jugador):
	var celdas_de_movimiento_permitido = {}
	var celda_jugador = grilla_principal.obtener_posicion_grilla(jugador)
	var celdas_adyacentes_al_jugador = grilla_principal.obtener_celdas_adyacentes(celda_jugador)
	
	for celda in celdas_adyacentes_al_jugador:
		evaluar_branch(celda_jugador, celda, jugador.data()["movimientos"], jugador, celdas_de_movimiento_permitido) 
	return celdas_de_movimiento_permitido.keys()
	
func evaluar_branch(celda_origen, celda_destino, movimiento_disponible, jugador, celdas_de_movimiento_permitido):
	var tipo_de_terreno_celda_destino = grilla_principal.obtener_info_de_celda(celda_destino)["tipo"]
	var coste_de_movimiento = jugador.coste_de_movimiento(tipo_de_terreno_celda_destino)
	var movimiento_disponible_branch = movimiento_disponible 
	if movimiento_disponible_branch >= coste_de_movimiento:
		movimiento_disponible_branch -= coste_de_movimiento
		
		if celdas_de_movimiento_permitido.has(celda_destino): 
			if celdas_de_movimiento_permitido[celda_destino] < movimiento_disponible_branch:
				celdas_de_movimiento_permitido[celda_destino] = movimiento_disponible_branch
			else:
				return  #Corta el algoritmo si la celda ya fue evaluada de forma más óptima
		else:
			celdas_de_movimiento_permitido[celda_destino] = movimiento_disponible_branch
		
		var celdas_adyacentes_celda_destino = grilla_principal.obtener_celdas_adyacentes(celda_destino)
		celdas_adyacentes_celda_destino.erase(celda_origen)
		
		for celda in celdas_adyacentes_celda_destino:
			evaluar_branch(celda_destino, celda, movimiento_disponible_branch, jugador, celdas_de_movimiento_permitido)
			
	

	
func puede_mover(jugador, movimiento_disponible, celda):
	var info_celda = grilla_principal.obtener_info_de_celda(celda)
	if(movimiento_disponible > 1 && info_celda['tipo'] == 'ruta'):
		return true
	return false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
