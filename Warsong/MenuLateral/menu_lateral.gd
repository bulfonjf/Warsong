extends Node

onready var orquestador : Node2D = get_node("/root/NodoPrincipal")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func mostrar():
	self.visible = true
func ocultar():
	self.visible = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Mover_pressed():
	orquestador.mostrar_movimiento_disponible()
	



func _on_NodoPrincipal_finalizado():
	self.ocultar()
	pass # Replace with function body.
