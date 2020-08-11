extends TileMap

onready var orquestador : Node2D = get_node("/root/NodoPrincipal")


#Ready
func _ready():
	pass 

#Se ejecuta cuando la grilla es clickeada
#le avisa al orquestador de la posicion del clickeo en formato pixels
#toma una posixion x,y, y devuelve la posicion de la esquia sup izquierda de la celda que se clickeo. 
func _input(event):
	if event is InputEventMouseButton && !event.is_pressed():
		var posicion = event.position  #toma la posicion del clickeo en pixeles
		var posicionv2 = world_to_map((posicion)) #convierte el formato x,y en formato ubicacion grilla
		var posicionxy = map_to_world((posicionv2)) #convierte el formato ubicacion grilla en formato x,y nuevamente
		orquestador.click_en_grilla(posicionxy) #llama a orquestador 
		

#Devuelve posicion de los nodos hijos en formato grilla (te da la ubicacion de la celda en la grilla) (devuelve un Vector2)
func obtener_posicion_grilla(nodo):
	var posicion = nodo.position
	var celda = world_to_map(posicion)
	return celda

#Devuelve posicion de las celdas en formato pixels (devuelve un Vector2)
func obtener_posicion_pixels(celdas):
	var posiciones : Array
	for celda in celdas:
		posiciones.append(map_to_world(celda))
	return posiciones
