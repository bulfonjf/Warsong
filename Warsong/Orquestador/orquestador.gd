extends Node


# COMPONENTES
onready var menu_lateral : Control = $MenuLateral
onready var grilla_principal: TileMap = $GrillaPrincipal
onready var grilla_movimiento: TileMap = $GrillaMovimiento
onready var algoritmo_movimiento: Node2D = $GrillaPrincipal/AlgoritmoMovimiento
onready var partida : Script = load("res://Partida/partida.gd")


# VARIABLES
onready var tamanio_de_celda : Vector2 = grilla_principal.get_cell_size()

#SEÑALES

# READY
func _ready():
	
	for equipo in partida.equipos:
		for tropa in equipo.tropas:
			#print(tropa.clase, equipo.nombre)
			var nueva_tropa = load("res://Partida/Unidades/Unidad.tscn").instance()
			nueva_tropa.init(tropa)
			var posicion : Vector2 = tropa.posicion
			var posicionTropaEnCeldas : Celda = Convertir.celda(posicion)
			var posicionTropa : Vector2 = grilla_principal.obtener_centro_celda(posicionTropaEnCeldas)
			self.agregar_actor(nueva_tropa, posicionTropa)
			nueva_tropa.add_to_group(equipo.nombre)
	
	pass 

#Jugador llama a esta funcion cuando es clickeado
#Setea el contexto de seleccion de tropa
#Muestra el MenuLateral en la posicion del tropa
func click_en_tropa(tropa):
	if Ataque.activo and SeleccionTropa.data_contexto.get("actor_activo") != tropa :
		var danio = Ataque.calcular_danio(SeleccionTropa.data_contexto.get("actor_activo"), tropa)
		tropa.actualizar_vida(danio)
		Ataque.add_dispose_menu(self.menu_lateral)
		Ataque.desactivar_contexto()
		Ataque.dispose()
	else:
		SeleccionTropa.dispose()	
		SeleccionTropa.activar_contexto()
		SeleccionTropa.set_actor_activo(tropa)
		SeleccionTropa.add_dispose_menu(self.menu_lateral)
		var adyacentes : Array = grilla_principal.obtener_celdas_ocupadas_adyacentes(grilla_principal.obtener_posicion_grilla(tropa))
		menu_lateral.mostrar(tropa.position, adyacentes)


#Highlaitea las grillas de movimiento disponibles
#la llama menu_lateral cuando hacen click en mover [func _on_Mover_pressed():]
func mostrar_movimiento_disponible():
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
	if SeleccionTropa.si_movimiento_activado() and SeleccionTropa.si_celda_resaltada(celda): 
		mover_actor_activo(celda_clickeada)
	
	
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
	
	
