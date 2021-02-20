extends Node

onready var grilla_principal: TileMap = get_node("/root/NodoPrincipal/GrillaPrincipal")

func obtener_celdas_zona_control(celdas_unidades_enemigas): #devuelve un array de Celdas con las celdas adyacentes a todas las unidades menos la indicada
	var celdas_zona_control : Array = []
	for celda in celdas_unidades_enemigas:
		var celdas_adyacentes_nodo = grilla_principal.obtener_celdas_adyacentes(celda)
		for celda_adyacente in celdas_adyacentes_nodo:
			if not celda_adyacente._in(celdas_zona_control):
				celdas_zona_control.append(celda_adyacente)
	return celdas_zona_control	

func _ready():
	pass 

func obtener_posicion_enemigos(_faccion):
	var unidades = get_tree().get_nodes_in_group("Unidades")
	var celdas_con_enemigos : Array = []
	for unidad in unidades:
		if not unidad.get_faccion() == _faccion:
			var posicion_nodo : Celda = grilla_principal.obtener_posicion_grilla(unidad)
			celdas_con_enemigos.append(posicion_nodo)
	return celdas_con_enemigos

#Devuelve las celdas donde el actor se puede mover
func obtener_celdas_donde_se_puede_mover(actor):
	#var celdas_donde_se_puede_mover : Array
	var celdas_unidades_enemigas :Array = obtener_posicion_enemigos(actor.get_faccion())
	var celdas_zona_control : Array = obtener_celdas_zona_control(celdas_unidades_enemigas) #Celdas adyacentes a todas las unidades que no son de la faccion del nodo
	var celdas_de_movimiento_permitido = {}  #Aca se van guardando las celdas evaluadas y su coste de movimeinto
	var celda_actor : Celda = grilla_principal.obtener_posicion_grilla(actor) #obtiene la celda actual del actor
	var celdas_adyacentes_al_actor = grilla_principal.obtener_celdas_adyacentes(celda_actor) #obtiene celdas adyacentes al actor

	for celda in celdas_adyacentes_al_actor: #LLama a evaluar_brach  por cada celda adyacente
		evaluar_branch(celda_actor, celda, actor.get_unidad().get_movimientos(), actor, celdas_de_movimiento_permitido, celdas_zona_control, celdas_unidades_enemigas) 
	
	for celda in celdas_de_movimiento_permitido:
		if celda_actor.vector == celda:
			celdas_de_movimiento_permitido.erase(celda)

	return celdas_de_movimiento_permitido
	
#evalua las celdas siguiendo un camino, 
#y les asigna un valor en base al heroe y  los tiles
#comienza con las cellas adyacentes al actor, y se va llamando recursivamente
func evaluar_branch(celda_origen: Celda, celda_destino: Celda, movimiento_disponible, actor, celdas_de_movimiento_permitido, celdas_zona_control, celdas_unidades_enemigas):
	var tipo_de_terreno_celda_destino = grilla_principal.obtener_info_de_celda(celda_destino)["tipo"] #obtiene el "tipo" de tile
	var coste_de_movimiento = actor.get_unidad().get_coste_de_movimiento(tipo_de_terreno_celda_destino) #coste de mov del tile segun el "tipo" de actor
	var movimiento_disponible_branch = movimiento_disponible #variable de movimiento disponibles interna
	
	if celda_origen._in(celdas_zona_control) and celda_destino._in(celdas_zona_control):
		return

	if movimiento_disponible_branch >= coste_de_movimiento: #evalua si le quedan mov disponibles al jug para mover a la celda
		if not celda_destino._in(celdas_unidades_enemigas):   #evalua si la celda está libre
			movimiento_disponible_branch -= coste_de_movimiento  #resta el coste de mov del tile al mov disponible del actor( la variable interna)
		
			if celdas_de_movimiento_permitido.has(celda_destino.vector):  #se fija si la celda ya ha sido evaluada
				if celdas_de_movimiento_permitido[celda_destino.vector] < movimiento_disponible_branch: #si la nueva evaluacion es más óptima, sobreescribe la anterior.
					celdas_de_movimiento_permitido[celda_destino.vector] = movimiento_disponible_branch
				else:
					return   #Corta el algoritmo si la celda ya fue evaluada de forma más óptima
			
			else: #si la celda no fue evaluada previamente, le asigna un valor a la celda
				celdas_de_movimiento_permitido[celda_destino.vector] = movimiento_disponible_branch
			
			var celdas_adyacentes_celda_destino = grilla_principal.obtener_celdas_adyacentes(celda_destino) #nuevas celdas adyacentes, para hacer la recursion de la funcion
			
			if celda_origen._in(celdas_zona_control):
				for celda in celdas_adyacentes_celda_destino:
					if celda._in(celdas_zona_control):
						celdas_adyacentes_celda_destino.erase(celda)

			celdas_adyacentes_celda_destino.erase(celda_origen) #elimina la celda de origen (que fue evaluada en las lineas de arriba) de las celdas adyacentes
			for celda in celdas_adyacentes_celda_destino: #la funcion de llama a si misma con las celdas adyacentes a la celda evaluada
				evaluar_branch(celda_destino, celda, movimiento_disponible_branch, actor, celdas_de_movimiento_permitido, celdas_zona_control, celdas_unidades_enemigas)
	
