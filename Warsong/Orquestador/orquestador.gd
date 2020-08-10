extends Node

onready var menu_lateral : Control = get_node("/root/NodoPrincipal/MenuLateral")
#onready var grilla_principal: TileMap = get_node("/root/NodoPrincipal/GrillaPrincipal")
onready var grilla_movimiento: TileMap = get_node("/root/NodoPrincipal/GrillaMovimiento")

# Declare member variables here. Examples:
var actor_actual


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func click_en_jugador(jugador):
	actor_actual = jugador
	menu_lateral.mostrar()
	
func mover_actor_actual():
	var celda_derecha = Vector2(1,0)
	var tile_a_resaltar = actor_actual.ubicacion_celda + celda_derecha
	grilla_movimiento.resaltar_tile(tile_a_resaltar)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
