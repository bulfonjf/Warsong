extends TileMap

onready var orquestador : Node2D = get_node("/root/NodoPrincipal")


#Ready
func _ready():
	pass 

#Se ejecuta cuando la grilla es clickeada
#le avisa al orquestador de la posicion del clickeo en formato pixels
#toma una posixion x,y, y devuelve la posicion del centro de la celda que se clickeo. 
func _input(event):
	if event is InputEventMouseButton && !event.is_pressed():
		var posicion = event.position  #toma la posicion del clickeo
		var posicionv2 = world_to_map((posicion)) #convierte el formato x,y en formato celda vector2
		var posicionxy = map_to_world((posicionv2)) #convierte el vector2 en formato x,y nuevamente
		orquestador.click_en_grilla(posicionxy) #llama a orquestador 
		

#Obtener posicion de un nodo hijo en formato Vector2 (te da la celda)
func obtener_posicion(nodo):
	var posicion = nodo.position
	var celda = world_to_map(posicion)
	return(celda)
