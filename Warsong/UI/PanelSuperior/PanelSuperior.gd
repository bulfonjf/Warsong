extends Panel
onready var panel_superiorHbox: Control = $HBoxPanelSuperior
onready var boton_pasar_turno: Button = $HBoxPanelSuperior/BtnPanelSuperior
onready var PanelAgregarUnidad = get_node("../../PanelAgregarUnidad")
onready var boton_agregar_unidad = $HBoxPanelSuperior/BtnAgregarUnidad
onready var partida = load("res://Partida/partida.gd")
var faccion_cliente

func _on_BtnPanelSuperior_pressed():
	rpc("terminar_turno")

remotesync func terminar_turno():
	Ronda.terminar_turno()
	var faccion_activa = Ronda.obtener_faccion_activa()
	panel_superiorHbox.actualizar_panel(faccion_activa)
	if faccion_activa == faccion_cliente:
		boton_agregar_unidad.disabled = false
		boton_pasar_turno.disabled = false
	else:
		boton_pasar_turno.disabled = true
		boton_agregar_unidad.disabled = true
func iniciar_panel():
	var faccion_activa = Ronda.obtener_faccion_activa()
	if faccion_activa == faccion_cliente:
		boton_pasar_turno.disabled = false
		boton_agregar_unidad.disabled = false
	else:
		boton_pasar_turno.disabled = true
		boton_agregar_unidad.disabled = true

	var _facciones = partida.obtener_facciones()
	for _faccion in _facciones:
		if _faccion.nombre == faccion_cliente:
			PanelAgregarUnidad.init(_faccion["tropas"])

func _on_BtnAgregarUnidad_pressed():
	PanelAgregarUnidad.visible = true
	

func _ready() -> void:
	
	pass 


