extends Control
#onready var texture : TextureProgress = $TextureProgress
var texture : TextureProgress 

func _ready():
	pass 

func iniciar(jugador : Node2D):
	texture = $TextureProgress
	texture.max_value = jugador.unidad.clase.vida
	self.rect_position = Vector2(-16,8)
	self.actualizar_vida(jugador)
	

func actualizar_vida(jugador : Node2D):
	texture.value = jugador.unidad.clase.vida
	if texture.value < (texture.max_value*0.33):
		texture.tint_progress = "f41d1d"
	elif texture.value < (texture.max_value*0.66) and texture.value > (texture.max_value*0.33):
		texture.tint_progress = "f6ff00"
	else:
		texture.tint_progress = "38ff00"

