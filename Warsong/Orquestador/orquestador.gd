extends Node

onready var menu_lateral : Control = get_node("/root/NodoPrincipal/MenuLateral")
onready var grilla_principal: TileMap = get_node("/root/NodoPrincipal/GrillaPrincipal")
onready var grilla_movimiento: TileMap = get_node("/root/NodoPrincipal/GrillaMovimiento")
onready var algoritmo_movimiento: Node2D = get_node("/root/NodoPrincipal/GrillaPrincipal/AlgoritmoMovimiento")
# VARIABLES
var actor_actual : Node2D
var movimiento_activado = false
var celdas_de_movimiento : Array
onready var tamanio_de_celda : Vector2 = grilla_principal.get_cell_size()
onready var contextos_activos = {}
#SEÑALES
signal finalizado


# READY.
func _ready():
	var jugador = load("res://Player/jugador.tscn").instance()
	self.agregar_actor(jugador, Vector2(16,16))
	
	var jugador2 = load("res://Player/jugador.tscn").instance()
	self.agregar_actor(jugador2, Vector2(48,48))
	
	pass 

func escribir(algo):
	print(algo)

#Jugador llama a esta funcion cuando es clickeado
#Setea el actor actual 
#Muestra el MenuLateral en la posicion del jugador
func click_en_jugador(jugador):
	var contexto_mover = self.get_node("/root/NodoPrincipal/Contexto")
	contexto_mover.data_contexto["actor_actual"] = jugador
	contexto_mover.finalizar_contexto["finalizar_mover"] = {
		"funcion" : funcref(self, "escribir"),
		"argumentos" : "hola mundo"
	}
	contextos_activos["mover_jugador"] = contexto_mover
	actor_actual = jugador
	menu_lateral.mostrar(actor_actual.position)
	
	
	

#Highlaitea las grillas de movimiento disponibles
#la llama menu_lateral cuando hacen click en mover [func _on_Mover_pressed():]
func mostrar_movimiento_disponible():
	movimiento_activado = true
	celdas_de_movimiento = algoritmo_movimiento.obtener_celdas_donde_se_puede_mover(actor_actual)
	grilla_movimiento.resaltar_celdas(celdas_de_movimiento)
	
	
#Grilla llama a esta funcion cuando es clickeada:
#Llama a mover_actor_actual, la funcion de abajo
func click_en_grilla(celda_clickeada):
	var celda = grilla_principal.pixeles_a_celda(celda_clickeada)
	if movimiento_activado and celda in celdas_de_movimiento:
		mover_actor_actual(celda_clickeada)


#Mueve al actor a la celda de destino:
#La llama "click_en_grilla"[orquestador.click_en_grilla]
func mover_actor_actual(posicion_final):
	var actor_actual_desde_contexto = contextos_activos["mover_jugador"].data_contexto["actor_actual"]
	grilla_principal.marcar_celda_como_libre(actor_actual_desde_contexto.position)
	actor_actual_desde_contexto.set_position(posicion_final+ (tamanio_de_celda/2))
	movimiento_activado = false
	grilla_principal.marcar_celda_como_ocupada(actor_actual_desde_contexto.position)
	contextos_activos["mover_jugador"].dispose()
	emit_signal("finalizado")

#Agrega un actor en la grilla_principal
func agregar_actor(actor: Node2D, posicion: Vector2):
	actor.set_position(posicion)
	grilla_principal.add_child(actor)
	grilla_principal.marcar_celda_como_ocupada(actor.position)



	
	
	
	

