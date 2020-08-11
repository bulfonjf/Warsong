extends TileMap

var tiles_resaltados


func _ready():
	pass 

#Highlaitea un tile de movimiento dispoible
#Es llamada por orquestador.mostrar_movimiento_disponible():
func resaltar_tile(ubicacion: Vector2):
	self.set_cellv(ubicacion, 0)


#Highlaitea una lista de tiles de movimiento disponible:
func resaltar_tiles(lista_tiles: Array):
	for tile in lista_tiles:
		self.resaltar_tile(tile)


#Borra los tiles highlaiteados:
#Espera la señal "finalizado" de orquestador.mover_actor_actual()
func _on_NodoPrincipal_finalizado():
	var tiles_resaltados = get_used_cells_by_id (0)
	for tile in tiles_resaltados:
		self.set_cellv(tile,-1)
	pass 
