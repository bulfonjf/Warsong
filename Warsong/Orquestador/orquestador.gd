extends Node

# COMPONENTES
onready var menu_lateral_mapa : Control = $CanvasLayer/UI/MargenUI/Panel/MenuLateralMapa
onready var menu_lateral : Control = $CanvasLayer/MenuLateral
onready var grilla_principal: TileMap = $GrillaPrincipal
onready var grilla_movimiento: TileMap = $GrillaMovimiento
onready var algoritmo_movimiento: Node2D = $GrillaPrincipal/AlgoritmoMovimiento
onready var partida : Script = load("res://Partida/partida.gd")
onready var faccion = load("res://Partida/Facciones/faccion_nodo.gd")
onready var edificio = load("res://Partida/Edificios/Edificio.tscn")

# VARIABLES
onready var tamanio_de_celda : Vector2 = grilla_principal.get_cell_size()

#SEÑALES

# READY
func _ready():
	preparar_ronda()
	preparar_facciones()
	preparar_edificios()

func preparar_ronda():
	var facciones_nombres = []
	for _faccion in partida.facciones: # reemplazar con list comprehension o algo asi
		facciones_nombres.append(_faccion.nombre)

	Ronda.init(facciones_nombres, partida.facciones[0].nombre)
	menu_lateral_mapa.mostrar_info_ronda()

func preparar_facciones():
	for faccion_data in partida.facciones:
		var faccion_nodo = faccion.new(faccion_data)
		self.add_child(faccion_nodo)
		for tropa in faccion_data.tropas:
			var posicion : Vector2 = tropa.posicion
			var posicionTropaEnCeldas : Celda = Convertir.celda(posicion)
			var posicionTropa_Vector : Vector2 = grilla_principal.obtener_centro_celda(posicionTropaEnCeldas)
			var posicionTropa_Pixel : Pixel = Convertir.pixel(posicionTropa_Vector)
			faccion_nodo.agregar_tropa(tropa, posicionTropa_Pixel)
			grilla_principal.marcar_celda_como_ocupada(posicionTropa_Pixel)

func preparar_edificios():
	for edificio_data in partida.edificios:
		var nuevo_edificio = edificio.instance()
		self.add_child(nuevo_edificio)
		nuevo_edificio.init(edificio_data)

#La Unidad llama a esta funcion cuando es clickeado
#Setea el contexto de seleccion de tropa
#Muestra el MenuLateral en la posicion del tropa
func click_en_tropa(tropa, posicion_click):
	if Ataque.activo and SeleccionTropa.data_contexto.get("actor_activo") != tropa : #WARNING No chequea que sea un target valido 
		SeleccionTropa.data_contexto.get("actor_activo").animar()
		var danio = Ataque.calcular_danio(SeleccionTropa.data_contexto.get("actor_activo"), tropa)
		tropa.actualizar_vida(danio)
		Ataque.dispose()
	else:
		SeleccionTropa.dispose()	
		SeleccionTropa.activar_contexto()
		SeleccionTropa.set_actor_activo(tropa)
		SeleccionTropa.add_dispose_menu(self.menu_lateral)
		SeleccionTropa.add_dispose_menu_mapa(self.menu_lateral_mapa)
		var adyacentes : Array = grilla_principal.obtener_celdas_ocupadas_adyacentes(grilla_principal.obtener_posicion_grilla(tropa))
		menu_lateral.mostrar(posicion_click, adyacentes)
		menu_lateral_mapa.mostrar_info_unidad()

#Highlaitea las grillas de movimiento disponibles
#la llama menu_lateral cuando hacen click en mover [func _on_Mover_pressed():]
func mostrar_movimiento_disponible(): #WARNING Validad que el contexto sea el correcto. Si el jugador está atacando, no puede mover. 
	SeleccionTropa.add_dispose_grilla_movimiento(grilla_movimiento)
	SeleccionTropa.activar_movimiento()
	var actor_activo = SeleccionTropa.get_actor_activo()
	var celdas_de_movimiento = algoritmo_movimiento.obtener_celdas_donde_se_puede_mover(actor_activo)
	SeleccionTropa.set_celdas_de_movimiento(celdas_de_movimiento)
	grilla_movimiento.resaltar_celdas(celdas_de_movimiento)
	
#Grilla llama a esta funcion cuando es clickeada:
#Llama a mover_actor_actual, la funcion de abajo
func click_en_grilla(celda_clickeada):
	var celda = grilla_principal.pixeles_a_celda(Convertir.pixel(celda_clickeada))
	if SeleccionTropa.si_movimiento_activado():
		if SeleccionTropa.si_celda_resaltada(celda): 
			mover_actor_activo(celda_clickeada)
		else:
			SeleccionTropa.dispose()
	elif Ataque.activo:
		if not celda._in(grilla_principal.celdas_ocupadas): #WARNING tendria que verificar celdas de ataque posibles, no solo ocupadas
			Ataque.dispose()

#Mueve al actor a la celda de destino:
#La llama "click_en_grilla"[orquestador.click_en_grilla]
func mover_actor_activo(posicion_final : Vector2):
	var actor_activo = SeleccionTropa.get_actor_activo()
	grilla_principal.marcar_celda_como_libre(Convertir.pixel(actor_activo.position))
	var posicion_en_pixeles : Vector2 = grilla_principal.obtener_centro_celda_desde_un_pixel(Convertir.pixel(posicion_final))
	actor_activo.set_position(posicion_en_pixeles)
	grilla_principal.marcar_celda_como_ocupada(Convertir.pixel(actor_activo.position))
	SeleccionTropa.dispose()

#Agrega un actor en la grilla_principal
func agregar_actor(actor: Node2D, posicion: Vector2):
	actor.set_position(posicion)
	grilla_principal.add_child(actor)
	grilla_principal.marcar_celda_como_ocupada(Convertir.pixel(actor.position))	 
	
func atacar():
	Ataque.activar_contexto()
	Ataque.add_dispose_menu(self.menu_lateral)
