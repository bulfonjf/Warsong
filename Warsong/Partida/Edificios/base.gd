extends "edificio_nodo.gd"

onready var orquestador : Node2D = get_node("/root/NodoPrincipal")

func _input(event):
	if event is InputEventMouseButton && !event.is_pressed():
		orquestador.mostrar_menu_base()