extends Panel

onready var VBoxDescripcionUnidad = $VBoxUnidad/VBoxDescripcionUnidad
onready var HBoxDescripcionUnidad = load("res://UI/MenuLateral/HBoxDescripcionUnidad.tscn")

signal BtnCrearUnidad(unidad_nombre)
var unidad 
func init(_unidades):
	for unidad in _unidades:
		var unidades = Data.obtener_unidades()
		for _unidad in unidades.keys():
			if _unidad == unidad:
				var unidad_a_crear = unidades[_unidad]
				var description_unidad = HBoxDescripcionUnidad.instance()
				description_unidad.connect("CheckBoxUnidad", self, "desactivar_checkboxs")
				description_unidad.connect("activar_checkboxs", self, "activar_checkboxs")
				description_unidad.name = unidad
				description_unidad.add_to_group("hboxdescripcionunidad")
				VBoxDescripcionUnidad.add_child(description_unidad)
				description_unidad.init(unidad_a_crear)
				
func desactivar_checkboxs(_nombre_unidad):
	var hboxs = get_tree().get_nodes_in_group("hboxdescripcionunidad")
	for hbox in hboxs:
		if str(hbox.name) == str(_nombre_unidad):
			hbox.activar_checkbox()
		else:
			hbox.desactivar_checkbox()

func activar_checkboxs():
	var hboxs = get_tree().get_nodes_in_group("hboxdescripcionunidad")
	for hbox in hboxs:
		hbox.activar_checkbox()

func _on_BtnCancelar_pressed():
	self.visible = false

func _on_BtnCrearUnidad_pressed():
	var hboxs = get_tree().get_nodes_in_group("hboxdescripcionunidad")
	for hbox in hboxs:
		if hbox._checkbox().pressed == true:
			emit_signal("BtnCrearUnidad")
			unidad = hbox.name
			self.visible = false
			return
		else:
			pass

func _ready() -> void:
	pass 
