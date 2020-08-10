extends TileMap

onready var orquestador : Node2D = get_node("/root/NodoPrincipal")
onready var nav = get_node("/root/NodoPrincipal/Navigation2D")
onready var jugador2 = get_node("/root/NodoPrincipal/Navigation2D/GrillaMovimiento2/jugador2")
var camino = []
var speed = 50
var delta = 1
var d = 1
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func mover_actor_actual(posicion_final):
	var posicion_final2 = posicion_final
	var posicion_inicial = orquestador.actor_actual.get_position()
	camino = nav.get_simple_path(posicion_inicial, posicion_final2)
	print(camino)
	for x in camino:
		jugador2.set_position(Vector2(x))
		yield(get_tree().create_timer(1.0), "timeout")
	#actor_actual.set_position(posicion_final+Vector2(64,64))
	
	#movimiento_activado = false
	#emit_signal("finalizado")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
