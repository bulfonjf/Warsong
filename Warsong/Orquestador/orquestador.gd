extends Node

onready var menu_lateral : Control = get_node("/root/NodoPrincipal/MenuLateral")
onready var grilla_principal: TileMap = get_node("/root/NodoPrincipal/GrillaPrincipal")
onready var grilla_movimiento: TileMap = get_node("/root/NodoPrincipal/GrillaMovimiento")

# VARIABLES
var actor_actual : Node2D

var movimiento_activado = false
#SEÑALES
signal finalizado


# READY.
func _ready():
	pass 

#Jugador llama a esta funcion cuando es clickeado
#Setea el actor actual 
#Muestra el MenuLateral en la posicion del jugador
func click_en_jugador(jugador):
	actor_actual = jugador
	menu_lateral.mostrar(actor_actual.position)
	

#Highlaitea las grillas de movimiento disponibles
#la llama menu_lateral cuando hacen click en mover [func _on_Mover_pressed():]
func mostrar_movimiento_disponible():
	movimiento_activado = true
	var celda_derecha = Vector2(1,0)
	var celda_izquierda = Vector2(-1,0)
	var celda_superior = Vector2(0,1)
	var celda_inferior = Vector2(0,-1)
	var celdas_mov = [celda_derecha, celda_izquierda, celda_inferior, celda_superior]
	for celda in celdas_mov:
		var tile_a_resaltar = grilla_principal.obtener_posicion_grilla(actor_actual) + celda #pide la posicin al a grilla y le suma una celda
		grilla_movimiento.resaltar_tile(tile_a_resaltar)
	
	
#Grilla llama a esta funcion cuando es clickeada:
#Llama a mover_actor_actual, la funcion de abajo
func click_en_grilla(celda_clickeada):
	if movimiento_activado:
		mover_actor_actual(celda_clickeada)

#Mueve al actor a la celda de destino:
#La llama "click_en_grilla"[orquestador.click_en_grilla]
func mover_actor_actual(posicion_final):
	actor_actual.set_position(posicion_final+Vector2(64,64))
	movimiento_activado = false
	emit_signal("finalizado")





