extends HBoxContainer

var key_value_component = load("res://UI/Componentes/KeyValue.tscn")


func actualizar_panel(value):
	var item_ui = key_value_component.instance()
	self.add_child(item_ui)
	item_ui.init("faccion", str(value))


