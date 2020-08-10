extends Node

onready var menu_lateral : Control = get_node("/root/NodoPrincipal/MenuLateral")
#onready var grilla_principal: TileMap = get_node("/root/NodoPrincipal/GrillaPrincipal")
onready var grilla_movimiento: TileMap = get_node("/root/NodoPrincipal/GrillaMovimiento")
onready var grilla_movimiento2: TileMap = get_node("/root/NodoPrincipal/Navigation2D/GrillaMovimiento2")
# Declare member variables here. Examples:
var nav
var camino
var actor_actual
signal finalizado
var movimiento_activado = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func click_en_jugador(jugador):
	actor_actual = jugador
	menu_lateral.mostrar()
	

func click_en_grilla(celda_clickeada):
	if movimiento_activado:
		grilla_movimiento2.mover_actor_actual(celda_clickeada)


func mostrar_movimiento_disponible():
	movimiento_activado = true
	var celda_derecha = Vector2(1,0)
	var tile_a_resaltar = actor_actual.ubicacion_celda + celda_derecha
	grilla_movimiento.resaltar_tile(tile_a_resaltar)
	
func mover_actor_actual(posicion_final):
	actor_actual.set_position(posicion_final+Vector2(64,64))
	movimiento_activado = false
	emit_signal("finalizado")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


# Replace with function body.
