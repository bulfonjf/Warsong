extends KinematicBody2D

onready var orquestador : Node2D = get_node("/root/NodoPrincipal")

# Declare member variables here. Examples:
var ubicacion_celda = Vector2(0,0)
var movimiento = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func obtener_celda():
	return ubicacion_celda
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_jugador_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && !event.is_pressed():
		orquestador.click_en_jugador(self)
