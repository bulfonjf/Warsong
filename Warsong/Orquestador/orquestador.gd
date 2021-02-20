extends Node

# COMPONENTES
onready var menu_lateral_mapa : Control = $CanvasLayer/UI/MargenUI/Panel/MenuLateralMapa
onready var menu_lateral : Control = $CanvasLayer/MenuLateral
onready var menu_base : Control = $CanvasLayer/MenuBase
onready var grilla_principal: TileMap = $GrillaPrincipal
onready var grilla_movimiento: TileMap = $GrillaMovimiento
onready var algoritmo_movimiento: Node2D = $GrillaPrincipal/AlgoritmoMovimiento
onready var partida : Script = preload("res://Partida/partida.gd")
onready var faccion = load("res://Partida/Facciones/faccion_nodo.gd")
onready var edificio = load("res://Partida/Edificios/Edificio.tscn")
onready var edificio_base = load("res://Partida/Edificios/Base.tscn")
onready var celda_seleccion : Node2D = $CeldaSeleccion
onready var camara2D: Node2D = $Camera2D
onready var panel_superiorHbox: Control = $CanvasLayer/UI/Panel_superior/Panel/HBoxPanelSuperior
onready var panel_superior: Panel = $CanvasLayer/UI/Panel_superior/Panel
onready var panel_agregar_unidad : Panel = $CanvasLayer/UI/PanelAgregarUnidad
#SIGNALS
signal facciones_listas()

# VARIABLES
onready var tamanio_de_celda : Vector2 = grilla_principal.get_cell_size()
onready var celdas_con_nodos = {}
var cantidad_de_jugadores
var faccion_cliente 
var facciones : Array
var _ignore
#FUNCIONES MULTI
func set_faccion(_faccion):
	self.faccion_cliente = _faccion

	# READY
func set_cantidad_de_jugadores(_cantidad):
	self.cantidad_de_jugadores = _cantidad
func _ready():
	print("mi faccion es " + faccion_cliente)
	preparar_menu_lateral()
	preparar_camara()
	preparar_facciones(faccion_cliente)
	yield(self, "facciones_listas") 
	print("facciones cargadas:")
	for _faccion in facciones:
		print(_faccion.nombre)
	preparar_ronda()
	print("ronda cargada")
	randomize()
	pass

func preparar_menu_base():
	_ignore = menu_base.connect("crear_unidad_en_base_signal", self, "crear_unidad_en_base")
	
func preparar_menu_lateral():
	_ignore = menu_lateral.connect("mostrar_movimiento_disponible_signal", self, "mostrar_movimiento_disponible")
	_ignore = menu_lateral.connect("atacar_signal", self, "atacar")
	_ignore = menu_lateral.connect("borrar_signal", self, "borrar")

func preparar_camara():
	var limites = grilla_principal.obtener_limites()
	var viewport_limites = get_viewport().get_size()
	camara2D.init(limites, viewport_limites)
	#var ancho_celda = tamanio_de_celda.y
	var alto_celda = tamanio_de_celda.x
	if faccion_cliente == "orcos":
		var posicion = Vector2(0, alto_celda)
		camara2D.set_position(posicion) 
	if faccion_cliente == "elfos":
		var posicion = Vector2(0, alto_celda) * 9
		camara2D.set_position(posicion)

func preparar_ronda():
	var facciones_nombres = []
	for _faccion in facciones: # reemplazar con list comprehension o algo asi
		facciones_nombres.append(_faccion.nombre)
	print("preparando ronda")
	Ronda.init(facciones_nombres, partida.facciones[0].nombre)
	_ignore = Ronda.connect("turno_iniciado", self, "actualizar_unidad_por_turno")
	print("ronda seteada, preparando menus")
	menu_lateral_mapa.mostrar_info_ronda()
	print("menu lateral cargado")
	panel_superiorHbox.actualizar_panel(Ronda.obtener_faccion_activa())
	panel_superior.faccion_cliente = faccion_cliente
	panel_superior.iniciar_panel()
	_ignore = panel_agregar_unidad.connect("BtnCrearUnidad", self, "preparar_unidad")
	print("panel superior cargado")
	

func preparar_facciones(_faccion):
	var _facciones = partida.obtener_facciones()
	for _faccion in _facciones:
		if faccion_cliente == _faccion.nombre:
			rpc_id(0, "agregar_faccion", _faccion)

remotesync func agregar_faccion(_faccion):
	
	var id_del_que_llama = get_tree().get_rpc_sender_id()
	var faccion_nodo = faccion.new(_faccion)
	faccion_nodo.name = faccion_nodo.get_faccion().nombre
	var _nombre_de_la_faccion = faccion_nodo.name
	faccion_nodo.set_network_master(id_del_que_llama)
	self.add_child(faccion_nodo)
	print("agregando faccion: ")
	print(_nombre_de_la_faccion)
	print("del cliente: ")
	print(id_del_que_llama)
	self.aniadir_faccion_a_la_lista(_faccion)

		
func aniadir_faccion_a_la_lista(_faccion):
	facciones.append(_faccion)
	if facciones.size() == cantidad_de_jugadores: 
		emit_signal("facciones_listas")
		

func preparar_unidad():
	SeleccionTropa.dispose()	
	SeleccionTropa.activar_contexto()
	SeleccionTropa.activar_agregar_unidad()
	SeleccionTropa.add_dispose_grilla_movimiento(grilla_movimiento)
	var _faccion = faccion_cliente
	if _faccion == "orcos":
		var celda = Convertir.celda(Vector2(0,6))
		var celdas_a_resaltar = grilla_principal.obtener_celdas_adyacentes(celda)
		celdas_a_resaltar.append(celda)
		SeleccionTropa.set_celdas_agregar_unidad(celdas_a_resaltar)
		grilla_movimiento.resaltar_celdas(celdas_a_resaltar, "agregar_unidad")
	if _faccion == "elfos":
		var celda = Convertir.celda(Vector2(0,15))
		var celdas_a_resaltar = grilla_principal.obtener_celdas_adyacentes(celda)
		celdas_a_resaltar.append(celda)
		SeleccionTropa.set_celdas_agregar_unidad(celdas_a_resaltar)
		grilla_movimiento.resaltar_celdas(celdas_a_resaltar, "agregar_unidad")
	#var posicion : Vector2 = Vector2(4,8)
	#rpc("agregar_unidad", _faccion, unidad, posicion)
	#faccion_nodo.agregar_unidad(unidad, posicionUnidad_Pixel)
	#grilla_principal.marcar_celda_como_ocupada(posicionUnidad_Pixel)
	
remotesync func actualizar_unidad_por_turno(total_rondas, _faccion_activa):
	var unidades = get_tree().get_nodes_in_group(_faccion_activa)
	for unidad in unidades:
		unidad.actualizar_unidad_por_turno(total_rondas)
	
remotesync func agregar_unidad(_faccion, _unidad, _posicion):
	var id_del_que_llama = get_tree().get_rpc_sender_id()
	var faccion_nodo = self.find_node( _faccion, true, false )
	var posicionUnidadEnCeldas : Celda = Convertir.celda(_posicion)
	var posicionUnidad_Vector : Vector2 = grilla_principal.obtener_centro_celda(posicionUnidadEnCeldas)
	var posicionUnidad_Pixel : Pixel = Convertir.pixel(posicionUnidad_Vector)
	faccion_nodo.agregar_unidad(_unidad, posicionUnidad_Pixel, id_del_que_llama)
	grilla_principal.marcar_celda_como_ocupada(posicionUnidad_Pixel)
		
#La Unidad llama a esta funcion cuando es clickeado #Setea el contexto de seleccion de tropa
#Muestra el MenuLateral en la posicion del tropa
func click_en_tropa(tropa, posicion_click):
	var info_nodo = tropa.obtener_info()
	if info_nodo.obtener_faccion() == faccion_cliente:
		SeleccionTropa.dispose()	
		SeleccionTropa.activar_contexto()
		SeleccionTropa.set_actor_activo(tropa)
		SeleccionTropa.add_dispose_menu(self.menu_lateral)
		SeleccionTropa.add_dispose_menu_mapa(self.menu_lateral_mapa)
		var adyacentes : Array = grilla_principal.obtener_celdas_ocupadas_adyacentes(grilla_principal.obtener_posicion_grilla(tropa))
		menu_lateral.mostrar(posicion_click, adyacentes)
		menu_lateral_mapa.mostrar_info_unidad_activa()
	else:
		SeleccionTropa.dispose()
		SeleccionTropa.add_dispose_menu_mapa(self.menu_lateral_mapa)
		menu_lateral_mapa.mostrar_info_unidad(tropa)
		
#Highlaitea las grillas de movimiento disponibles
#la llama menu_lateral cuando hacen click en mover [func _on_Mover_pressed():]
func mostrar_movimiento_disponible(): #WARNING Validad que el contexto sea el correcto. Si el jugador está atacando, no puede mover. 
	SeleccionTropa.add_dispose_grilla_movimiento(grilla_movimiento)
	SeleccionTropa.activar_accion_movimiento()
	SeleccionTropa.add_dispose_acciones()
	var actor_activo = SeleccionTropa.get_actor_activo()
	var celdas_de_movimiento_permitido = algoritmo_movimiento.obtener_celdas_donde_se_puede_mover(actor_activo)
	var celdas_donde_se_puede_mover = []
	for celda in celdas_de_movimiento_permitido.keys():  #Pasar las celdas a formato Celda antes de devolverlas
			var celda_convertida = Convertir.celda(celda)
			celdas_donde_se_puede_mover.append(celda_convertida)
	#SeleccionTropa.set_celdas_de_movimiento(celdas_donde_se_puede_mover)
	SeleccionTropa.set_celdas_de_movimiento(celdas_de_movimiento_permitido)
	grilla_movimiento.resaltar_celdas(celdas_donde_se_puede_mover, "movimiento")
	

#Grilla llama a esta funcion cuando es clickeada:
#Llama a mover_actor_actual, la funcion de abajo
func click_en_grilla(celda_clickeada):
	var celda = grilla_principal.pixeles_a_celda(Convertir.pixel(celda_clickeada))
	if SeleccionTropa.si_movimiento_activado():
		if SeleccionTropa.si_celda_resaltada(celda): 
			var coste_de_movimiento = SeleccionTropa.get_coste_de_moviento_celda(celda)
			mover_actor_activo(celda_clickeada, coste_de_movimiento)
		else:
			SeleccionTropa.dispose()
	elif SeleccionTropa.si_agregar_unidad_activado():
		if SeleccionTropa.si_celda_resaltada_agregar_unidad(celda):
			var _faccion = faccion_cliente
			var unidad = panel_agregar_unidad.unidad
			var posicion = celda.vector
			rpc("agregar_unidad", _faccion, unidad, posicion)
			SeleccionTropa.dispose()
	else:
		SeleccionTropa.dispose()
	

#Mueve al actor a la celda de destino:
#La llama "click_en_grilla"[orquestador.click_en_grilla]
func mover_actor_activo(posicion_final : Vector2, _coste_de_movimiento):
	var actor_activo = SeleccionTropa.get_actor_activo()
	var path_actor = actor_activo.get_path()
	var _celda_liberada_vector = actor_activo.position
	#grilla_principal.marcar_celda_como_libre(Convertir.pixel(actor_activo.position))
	var posicion_en_pixeles : Vector2 = grilla_principal.obtener_centro_celda_desde_un_pixel(Convertir.pixel(posicion_final))
	#actor_activo.set_position(posicion_en_pixeles)
	#grilla_principal.marcar_celda_como_ocupada(Convertir.pixel(actor_activo.position))
	#self.guardar_celda_nodo(actor_activo)
	rpc("actualizar_movimiento_actor", path_actor, _celda_liberada_vector, posicion_en_pixeles, _coste_de_movimiento)
	SeleccionTropa.dispose()
	

remotesync func actualizar_movimiento_actor(_path_actor, _celda_liberada_vector, _posicion_final, _coste_de_movimiento):
	var actor_activo= get_node(_path_actor)
	var _celda_liberada = Convertir.pixel(_celda_liberada_vector)
	grilla_principal.marcar_celda_como_libre(_celda_liberada)
	actor_activo.set_position(_posicion_final)
	actor_activo.actualizar_movimiento(_coste_de_movimiento)
	grilla_principal.marcar_celda_como_ocupada(Convertir.pixel(actor_activo.position))
	pass 

#Agrega un actor en la grilla_principal
func agregar_actor(actor: Node2D, posicion: Vector2):
	actor.set_position(posicion)
	grilla_principal.add_child(actor)
	grilla_principal.marcar_celda_como_ocupada(Convertir.pixel(actor.position))	 

#La llama menu_lateral cuanndo se hace click en atacar
func atacar():
	grilla_movimiento.quitar_celdas_resaltadas()
	SeleccionTropa.activar_ataque()
	SeleccionTropa.add_dispose_acciones()
	SeleccionTropa.add_dispose_menu(self.menu_lateral)
	
remotesync func atacar_unidad(_path_actor_ataque, _path_actor_defensa, danio_al_atacante, danio_al_que_defiende):
	var actor_ataque= get_node(_path_actor_ataque)
	var actor_defensa= get_node(_path_actor_defensa)
	#actor_ataque.animar()
	actor_defensa.actualizar_vida(danio_al_que_defiende)
	#if actor_defensa.has_node(_path_actor_defensa):
	actor_ataque.actualizar_vida(danio_al_atacante)
	actor_ataque.desactivar_ataque()

	pass


func _unhandled_input(event): #ToDo, demasiada conversiones de formato(pixel,celda) coordinar con la funcion de abajo y con celda_seleccion
	if event is InputEventMouseButton && !event.is_pressed():
		var posicion = event.position * camara2D.zoom + camara2D.position  #toma la posicion del clickeo en pixeles
		var click_en_pixel =Convertir.pixel(posicion)
		var centro_de_celda = grilla_principal.obtener_centro_celda_desde_un_pixel(click_en_pixel)
		celda_seleccion.mover(centro_de_celda)
		self.click_en_pantalla(centro_de_celda, event.position)
		get_tree().set_input_as_handled()



func guardar_celda_nodo(nodo: Node2D):
	var posicion_pixel =Convertir.pixel(nodo.position)
	var posicion_celda = grilla_principal.pixeles_a_celda(posicion_pixel)
	celdas_con_nodos[nodo.get_instance_id()] = posicion_celda.vector
	
	
func obtener_nodo_en_celda(celda_vector2) -> Node2D:
	#var celda = Convertir.celda(celda_vector2)
	var unidades = get_tree().get_nodes_in_group("Unidades")
	for unidad in unidades:
		var posicion_celda = grilla_principal.obtener_posicion_grilla(unidad)
		if celda_vector2.vector == posicion_celda.vector:
			return unidad
	#for nodo_id in celdas_con_nodos.keys():
	#	if celdas_con_nodos[nodo_id] == celda.vector:
	#		return nodo_id
	return null


func click_en_pantalla(centro_celda_clickeada : Vector2, evento_posicion):	#ToDo, demasiada conversiones de formato(pixel,celda), coordinar con la funcion de arriba
	var click_en_pixel =Convertir.pixel(centro_celda_clickeada)				#Todo, ver como distribuir esto en distintos componentes
	var click_formato_celda = grilla_principal.pixeles_a_celda(click_en_pixel)
	var nodo_en_celda = self.obtener_nodo_en_celda(click_formato_celda)
	if nodo_en_celda:
		var nodo = nodo_en_celda#instance_from_id(nodo_en_celda)
		var info_nodo = nodo.obtener_info()
		if info_nodo is Unidad:
			if faccion_cliente == Ronda.obtener_faccion_activa():
				if info_nodo.obtener_faccion() == Ronda.obtener_faccion_activa():
					self.click_en_tropa(nodo, evento_posicion)
				else:
					var actor_activo = SeleccionTropa.data_contexto.get("actor_activo")
					if  "atacando" in SeleccionTropa.get_acciones():
							var path_actor_activo = actor_activo.get_path()
							var path_nodo = nodo.get_path()
							var danio_al_que_defiende = Ataque.calcular_danio_defensa(actor_activo, nodo)
							var danio_al_atacante = Ataque.calcular_danio_ataque(actor_activo, nodo)
							rpc("atacar_unidad", path_actor_activo, path_nodo, danio_al_atacante, danio_al_que_defiende)
							SeleccionTropa.dispose()
					else:
						SeleccionTropa.dispose()
						SeleccionTropa.add_dispose_menu_mapa(self.menu_lateral_mapa)
						menu_lateral_mapa.mostrar_info_unidad(nodo)
			else:
				SeleccionTropa.dispose()
				SeleccionTropa.add_dispose_menu_mapa(self.menu_lateral_mapa)
				menu_lateral_mapa.mostrar_info_unidad(nodo)
	else:
		self.click_en_grilla(centro_celda_clickeada)


func borrar_nodo_en_celda(nodo) :
	celdas_con_nodos.erase(nodo.get_instance_id()) 

func borrar():
	var actor_activo = SeleccionTropa.get_actor_activo()
	self.borrar_nodo_en_celda(actor_activo)
	grilla_principal.marcar_celda_como_libre(Convertir.pixel(actor_activo.position))
	actor_activo.queue_free()
	SeleccionTropa.dispose()


