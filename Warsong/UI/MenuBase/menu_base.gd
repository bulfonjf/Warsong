extends Control

onready var orquestador : Node2D = get_node("/root/NodoPrincipal")
var clase_unidad = ""
var equipamiento_defensa = []
var equipamiento_ataque = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _on_FigtherTB_pressed():
	self.clase_unidad = "fighter"

func _on_CaballeroTB_pressed():
	self.clase_unidad = "caballero"
	
func _on_RangoTB_pressed():
	self.clase_unidad = "rango"

func _on_CrearUnidadBtn_pressed():
	orquestador.crear_unidad_en_base()

func _on_CerrarBtn_pressed():
	self.visible = false

func obtener_clase_unidad():
	return self.clase_unidad

func obtener_equipamiento_defensa():
	return equipamiento_defensa

func obtener_equipamiento_ataque():
	return equipamiento_ataque
