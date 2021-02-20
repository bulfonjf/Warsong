extends TileMap

var tiles_resaltados

func _ready():
	pass 

#Highlaitea un tile de movimiento dispoible
#Es llamada por orquestador.mostrar_movimiento_disponible():
func resaltar_tile_movimiento(ubicacion: Vector2):
	self.set_cellv(ubicacion, 2)
	var tileset = self.get_tileset()
	tileset.tile_set_modulate( 2, Color("#65f1f303"))
func resaltar_tile_agregar_unidad(ubicacion: Vector2):
	self.set_cellv(ubicacion, 2)
	var tileset = self.get_tileset()
	tileset.tile_set_modulate( 2, Color("#6d3de26e"))

#Highlaitea una lista de tiles de movimiento disponible:
func resaltar_celdas(lista_celdas: Array, _tipo_resaltado):
	for celda in lista_celdas:
		if _tipo_resaltado == "movimiento":
			self.resaltar_tile_movimiento((celda.vector))
		elif _tipo_resaltado == "agregar_unidad":
			self.resaltar_tile_agregar_unidad((celda.vector))

#Borra los tiles highlaiteados:
func quitar_celdas_resaltadas():
	var _tiles_resaltados = get_used_cells_by_id(2) #TODO revisar si se tiene que pisar tiles_resaltados o se crea una variable nueva
	for tile in _tiles_resaltados:
		self.set_cellv(tile, -1)
