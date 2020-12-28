extends Control

onready var orquestador : Node2D = get_node("/root/NodoPrincipal")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_CrearUnidadBtn_pressed():
	print("crear unidad")