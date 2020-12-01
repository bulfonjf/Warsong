extends TileMap

onready var orquestador : Node2D = get_node("/root/NodoPrincipal")
onready var data: Node2D = get_node("/root/NodoPrincipal/GrillaPrincipal/Data")
onready var camara2D: Node2D = get_node("/root/NodoPrincipal/Camera2D")


#Variables:
var celdas_ocupadas : Array

#Devuelve las celdas_ocupadas
func obtener_celdas_ocupadas():
	return celdas_ocupadas

#Marcar celda como desocupada:
func marcar_celda_como_libre(posicion: Vector2):
	var celda = self.pixeles_a_celda(posicion)
	celdas_ocupadas.erase(celda)
	
#Marcar celda como ocupada
func marcar_celda_como_ocupada(posicion: Vector2):
	var celda = self.pixeles_a_celda(posicion)
	if not celda in celdas_ocupadas:
		celdas_ocupadas.append(celda)
	
#Obtiene las celdas adyacentes a una celda
func obtener_celdas_adyacentes(celda : Vector2):
	var celda_derecha = celda + Vector2(1,0)
	var celda_izquierda = celda + Vector2(-1,0)
	var celda_superior =  celda + Vector2(0,1)
	var celda_inferior = celda + Vector2(0,-1)
	var celdas_adyacentes = [celda_derecha, celda_izquierda, celda_inferior, celda_superior]
	return celdas_adyacentes

#Se ejecuta cuando la grilla es clickeada
#le avisa al orquestador de la posicion del clickeo en formato pixels
#toma una posixion x,y, y devuelve la posicion de la esquia sup izquierda de la celda que se clickeo. 
func _input(event):
	if event is InputEventMouseButton && !event.is_pressed():
		var zoom = camara2D.get_zoom()
		var posicion = event.position * camara2D.zoom + camara2D.position  #toma la posicion del clickeo en pixeles
		var posicionv2 = world_to_map((posicion)) #convierte el formato x,y en formato ubicacion grilla
		var posicionxy = map_to_world((posicionv2)) #convierte el formato ubicacion grilla en formato x,y nuevamente
		orquestador.click_en_grilla(posicionxy) #llama a orquestador 
		
#Devuelve posicion de los nodos hijos en formato grilla (te da la ubicacion de la celda en la grilla) (devuelve un Vector2)
func obtener_posicion_grilla(nodo : Node2D):
	var posicion = nodo.position
	var celda = world_to_map(posicion)
	return celda

#Devuelve posicion en celdas de un formato pixels (devuelve formato grilla)
func pixeles_a_celda(posicion : Vector2):
	var celda = world_to_map(posicion)
	return celda


#Devuelve posicion de las celdas en formato pixels (devuelve un Vector2)
func obtener_posicion_pixels(celdas):
	var posiciones : Array
	for celda in celdas:
		posiciones.append(map_to_world(celda))
	return posiciones


#Devuelve la data de una celda
func obtener_info_de_celda(ubicacion_celda: Vector2):
	var tile_id = self.get_cellv(ubicacion_celda)
	if(tile_id == -1):
		return data.terrenos["empty"]
	var tile_name = self.tile_set.tile_get_name(tile_id)
	return data.terrenos[tile_name]
	

#Devuelve el tamaño de la grilla en pixeles
func obtener_limites():
		var celda_size = self.get_cell_size()
		var celda = self.get_used_cells()[-1]
		var limites =  celda * celda_size.x + celda_size # cantidad de celdas * tamanio en pixeles + 1 celda mas porquue las coordenadas son de  la esquina superior izquierda
		return limites
		
