extends VBoxContainer

func mostrar_info_unidad():
	var actor_activo = SeleccionTropa.get_actor_activo()
	var categoria_unidad = load("res://UI/MenuLateralMapa/CategoriaUnidad.tscn").instance()
	self.add_child(categoria_unidad)
	categoria_unidad.init_unidad(actor_activo.get_unidad())

func quitar_info():
	for child in self.get_children():
		child.queue_free()
		self.remove_child(child)