extends Camera2D

onready var grilla_principal: TileMap = get_node("/root/NodoPrincipal/GrillaPrincipal")
onready var grilla_principal_celda_size : Vector2 = grilla_principal.get_cell_size()
onready var alto_celda = grilla_principal_celda_size.y
onready var ancho_celda = grilla_principal_celda_size.x
onready var nodo_principal : Node2D = get_node("/root/NodoPrincipal")

#obtiene las medidas del vieport 
onready var viewport_size = nodo_principal.get_viewport().get_size()

var limites : Vector2

#mueve la camara con los imputs de las teclas
#chequea que no pasen los limites
func _input(_event):
	if Input.is_action_pressed("ui_right"):
		var derecha = self.position + Vector2(ancho_celda, 0)
		if derecha.x <= self.limit_right - (viewport_size.x * self.zoom.x): # el limite derecho es igual a la coordenaa de la ultima celda de la grilla principal + 1 ancho de celda (pq la coordenada es esquina superior izquierda) - el ancho del tamanio de la ventana
			self.set_position(derecha) 
			
	elif Input.is_action_pressed("ui_left"):
		var izquierda = self.position + Vector2(-ancho_celda, 0)
		if izquierda.x >= 0:
			self.set_position(izquierda) 
			
	elif Input.is_action_pressed("ui_down"):
		var abajo = self.position + Vector2(0, alto_celda)
		if abajo.y <= self.limit_bottom - (viewport_size.y * self.zoom.y):
			self.set_position(abajo) 
			
	elif Input.is_action_pressed("ui_up"):
		var arriba = self.position + Vector2(0, -alto_celda)
		if arriba.y >= 0:
			self.set_position(arriba) 
			
#setea los limites de la camara
func _ready():
	limites = grilla_principal.obtener_limites()
	self.limit_bottom = int(limites.y)
	self.limit_right = int(limites.x)
	self.limit_top = 0
	self.limit_left = 0
	
	pass 




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
