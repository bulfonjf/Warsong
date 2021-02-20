extends HBoxContainer

onready var PanelAgregarUnidad = get_node("../../../../PanelAgregarUnidad")
onready var nombre = $LabelNombre
onready var ataque = $GridContainer/LabelValorAtaque
onready var defensa = $GridContainer/LabelValorDefensa
onready var vida = $GridContainer/LabelValorVida
onready var movimiento = $GridContainer/LabelValorMovimiento
onready var critico = $GridContainer/LabelValorAtaqueCritico
onready var esquiva = $GridContainer/LabelValorEsquiva
onready var checkbox =$CheckBoxUnidad

signal CheckBoxUnidad(_nombre_unidad)
signal activar_checkboxs()
var nombre_unidad
var _ignore
var checkbox_activado: bool = false

func init(unidad):
	nombre_unidad = unidad["nombre"]
	nombre.text = unidad["nombre"]
	ataque.text = str(unidad.ataque)
	defensa.text = str(unidad.defensa)
	vida.text = str(unidad.vida)
	movimiento.text = str(unidad.movimientos)
	critico.text = str(unidad.ataque_critico)
	esquiva.text = str(unidad.esquiva)
	pass

func _ready() -> void:
	pass 
	
func _on_CheckBoxUnidad_toggled(_presionado):
	if _presionado == true:
		emit_signal("CheckBoxUnidad", self.name)
	if _presionado == false: 
		emit_signal("activar_checkboxs")
	pass 

func desactivar_checkbox():
	checkbox.pressed = false
	checkbox_activado = false
func activar_checkbox():
	#checkbox.pressed = false
	checkbox_activado = true

func _checkbox():
	return self.checkbox
