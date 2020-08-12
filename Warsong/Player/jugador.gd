extends KinematicBody2D

onready var orquestador : Node2D = get_node("/root/NodoPrincipal")

# Variables:
#var movimiento, ¿En algun momento la usaremos? por ahora no
export var movimiento = 3

# Ready
func _ready():
	pass # Replace with function body.


#Funcion que se ejecuta cuando clickean al jugador
func _on_jugador_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && !event.is_pressed():
		orquestador.click_en_jugador(self)
