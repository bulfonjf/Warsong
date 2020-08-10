extends TileMap

onready var orquestador : Node2D = get_node("/root/NodoPrincipal")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton && !event.is_pressed():
		var posicion = event.position
		var posicionv = world_to_map((posicion))
		var posicionx = map_to_world((posicionv))
		orquestador.click_en_grilla(posicionx)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
