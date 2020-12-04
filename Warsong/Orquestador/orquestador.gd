extends Node


# COMPONENTES
onready var menu_lateral : Control = get_node("/root/NodoPrincipal/MenuLateral")
onready var grilla_principal: TileMap = get_node("/root/NodoPrincipal/GrillaPrincipal")
onready var grilla_movimiento: TileMap = get_node("/root/NodoPrincipal/GrillaMovimiento")
onready var algoritmo_movimiento: Node2D = get_node("/root/NodoPrincipal/GrillaPrincipal/AlgoritmoMovimiento")
onready var partida : Script = load("res://Partida/partida.gd")

# VARIABLES
onready var tamanio_de_celda : Vector2 = grilla_principal.get_cell_size()
#onready var contextos_activos = {}


#SEÑALES


# READY
func _ready():
	
	
	
	for jugadorPartida in partida.data["jugadores"]:
		var jugador = load("res://Player/jugador.tscn").instance()
		
		var posicion : Vector2 = jugadorPartida["posicion_inicial"]
		var posicionJugadorPartidaEnCeldas : Celda = Convertir.celda(posicion)
		var posicionJugador : Vector2 = grilla_principal.obtener_centro_celda(posicionJugadorPartidaEnCeldas)
		self.agregar_actor(jugador, posicionJugador)
		for grupo in jugadorPartida["grupos"]:
			jugador.add_to_group(grupo)
	
	pass 

#func eliminar_contexto(nombre_contexto):
#	contextos_activos[nombre_contexto].dispose()
#	contextos_activos.erase(nombre_contexto)

#Jugador llama a esta funcion cuando es clickeado
#Setea el contexto de seleccion de jugador
#Muestra el MenuLateral en la posicion del jugador
func click_en_jugador(jugador):
	SeleccionJugador.dispose()	
	SeleccionJugador.activar_contexto()
	SeleccionJugador.set_actor_activo(jugador)
	SeleccionJugador.add_dispose_menu(self.menu_lateral)
	menu_lateral.mostrar(jugador.position)


#Highlaitea las grillas de movimiento disponibles
#la llama menu_lateral cuando hacen click en mover [func _on_Mover_pressed():]
func mostrar_movimiento_disponible():
	SeleccionJugador.add_dispose_grilla_movimiento(grilla_movimiento)
	SeleccionJugador.activar_movimiento()
	var actor_activo = SeleccionJugador.get_actor_activo()
	var celdas_de_movimiento = algoritmo_movimiento.obtener_celdas_donde_se_puede_mover(actor_activo)
	SeleccionJugador.set_celdas_de_movimiento(celdas_de_movimiento)
	grilla_movimiento.resaltar_celdas(celdas_de_movimiento)
	
	
#Grilla llama a esta funcion cuando es clickeada:
#Llama a mover_actor_actual, la funcion de abajo
func click_en_grilla(celda_clickeada):
	var celda = grilla_principal.pixeles_a_celda(Convertir.pixel(celda_clickeada))
	if SeleccionJugador.si_movimiento_activado() and SeleccionJugador.si_celda_resaltada(celda): 
		mover_actor_activo(celda_clickeada)
	print(grilla_principal.celdas_ocupadas)

#Mueve al actor a la celda de destino:
#La llama "click_en_grilla"[orquestador.click_en_grilla]
func mover_actor_activo(posicion_final : Vector2):
	var actor_activo = SeleccionJugador.get_actor_activo()
	grilla_principal.marcar_celda_como_libre(Convertir.pixel(actor_activo.position))
	var posicion_en_pixeles : Vector2 = grilla_principal.obtener_centro_celda_desde_un_pixel(Convertir.pixel(posicion_final))
	actor_activo.set_position(posicion_en_pixeles)
	grilla_principal.marcar_celda_como_ocupada(Convertir.pixel(actor_activo.position))
	SeleccionJugador.dispose()


#Agrega un actor en la grilla_principal
func agregar_actor(actor: Node2D, posicion: Vector2):
	actor.set_position(posicion)
	grilla_principal.add_child(actor)
	grilla_principal.marcar_celda_como_ocupada(Convertir.pixel(actor.position))	 
