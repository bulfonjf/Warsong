extends Camera2D

onready var grilla_principal: TileMap = get_node("/root/NodoPrincipal/GrillaPrincipal")

var limites : Vector2

func _input(event):
	print(self.position)
	if Input.is_action_pressed("ui_right"):
		var derecha = self.position + Vector2(128,0)
		if derecha.x <= self.limit_right:
			self.set_position(derecha) 
	elif Input.is_action_pressed("ui_left"):
		var izquierda = self.position + Vector2(-128,0)
		if izquierda.x >= 0:
			self.set_position(izquierda) 
	elif Input.is_action_pressed("ui_down"):
		var abajo = self.position + Vector2(0,128)
		if abajo.y <= self.limit_bottom:
			self.set_position(abajo) 
	elif Input.is_action_pressed("ui_up"):
		var arriba = self.position + Vector2(0,-128)
		if arriba.y >= 0:
			self.set_position(arriba) 
# Called when the node enters the scene tree for the first time.
func _ready():
	limites = grilla_principal.obtener_limites()
	self.limit_bottom = limites.y
	self.limit_right = limites.x
	self.limit_top = 0
	self.limit_left = 0
	pass 




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
