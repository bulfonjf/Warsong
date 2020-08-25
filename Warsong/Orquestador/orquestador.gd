extends Node


# COMPONENTES
onready var menu_lateral : Control = get_node("/root/NodoPrincipal/MenuLateral")
onready var grilla_principal: TileMap = get_node("/root/NodoPrincipal/GrillaPrincipal")
onready var grilla_movimiento: TileMap = get_node("/root/NodoPrincipal/GrillaMovimiento")
onready var algoritmo_movimiento: Node2D = get_node("/root/NodoPrincipal/GrillaPrincipal/AlgoritmoMovimiento")


# VARIABLES
onready var tamanio_de_celda : Vector2 = grilla_principal.get_cell_size()
onready var contextos_activos = {}


#SEÑALES


# READY
func _ready():
	var jugador = load("res://Player/jugador.tscn").instance()
	self.agregar_actor(jugador, Vector2(16,16))
	
	var jugador2 = load("res://Player/jugador.tscn").instance()
	self.agregar_actor(jugador2, Vector2(48,48))
	
	pass 

func eliminar_contexto(nombre_contexto):
	contextos_activos[nombre_contexto].dispose()
	contextos_activos.erase(nombre_contexto)

#Jugador llama a esta funcion cuando es clickeado
#Setea el contexto de seleccion de jugador
#Muestra el MenuLateral en la posicion del jugador
func click_en_jugador(jugador):
	if "seleccion_jugador" in contextos_activos:
		eliminar_contexto("seleccion_jugador")
	var contexto_seleccion_jugador = load("res://Contexto/Contexto.tscn").instance()
	contexto_seleccion_jugador.data_contexto["actor_actual"] = jugador
	contexto_seleccion_jugador.agregar_dispose(funcref(self.menu_lateral, "ocultar"))
	contextos_activos["seleccion_jugador"] = contexto_seleccion_jugador
	menu_lateral.mostrar(jugador.position)


#Highlaitea las grillas de movimiento disponibles
#la llama menu_lateral cuando hacen click en mover [func _on_Mover_pressed():]
func mostrar_movimiento_disponible():
	contextos_activos["seleccion_jugador"].agregar_dispose(funcref(grilla_movimiento, "quitar_celdas_resaltadas"))
	contextos_activos["seleccion_jugador"].acciones.append("mover_jugador_seleccionado")
	var actor_actual = contextos_activos["seleccion_jugador"].data_contexto["actor_actual"]
	contextos_activos["seleccion_jugador"].data_contexto["celdas_de_movimiento"] = algoritmo_movimiento.obtener_celdas_donde_se_puede_mover(actor_actual)
	grilla_movimiento.resaltar_celdas(contextos_activos["seleccion_jugador"].data_contexto["celdas_de_movimiento"])
	
	
#Grilla llama a esta funcion cuando es clickeada:
#Llama a mover_actor_actual, la funcion de abajo
func click_en_grilla(celda_clickeada):
	var celda = grilla_principal.pixeles_a_celda(celda_clickeada)
	if "seleccion_jugador" in contextos_activos.keys() \
		and "mover_jugador_seleccionado" in contextos_activos["seleccion_jugador"].acciones \
		and celda in contextos_activos["seleccion_jugador"].data_contexto["celdas_de_movimiento"]:
		mover_actor_actual(celda_clickeada)


#Mueve al actor a la celda de destino:
#La llama "click_en_grilla"[orquestador.click_en_grilla]
func mover_actor_actual(posicion_final):
	var actor_actual = contextos_activos["seleccion_jugador"].data_contexto["actor_actual"]
	grilla_principal.marcar_celda_como_libre(actor_actual.position)
	actor_actual.set_position(posicion_final+ (tamanio_de_celda/2))
	grilla_principal.marcar_celda_como_ocupada(actor_actual.position)
	eliminar_contexto("seleccion_jugador")


#Agrega un actor en la grilla_principal
func agregar_actor(actor: Node2D, posicion: Vector2):
	actor.set_position(posicion)
	grilla_principal.add_child(actor)
	grilla_principal.marcar_celda_como_ocupada(actor.position)
