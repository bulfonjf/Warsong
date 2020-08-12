extends Node2D

onready var grilla_principal: TileMap = get_node("/root/NodoPrincipal/GrillaPrincipal")


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func obtener_celdas_donde_se_puede_mover(jugador):
	var movimiento_disponible = jugador.movimiento
	var celda_actor_posicion = grilla_principal.obtener_posicion_grilla(jugador)
	var celdas_adyacentes = grilla_principal.obtener_celdas_adyacentes(celda_actor_posicion)
	var celdas_donde_se_puede_mover = []
	for celda in celdas_adyacentes:
		if(puede_mover(jugador, movimiento_disponible, celda)):
			celdas_donde_se_puede_mover.append(celda)
	return celdas_donde_se_puede_mover
	
func puede_mover(jugador, movimiento_disponible, celda):
	var info_celda = grilla_principal.obtener_info_de_celda(celda)
	if(movimiento_disponible > 1 && info_celda['tipo'] == 'ruta'):
		return true
	return false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
