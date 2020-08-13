extends KinematicBody2D

onready var orquestador : Node2D = get_node("/root/NodoPrincipal")
onready var data = get_node("/root/NodoPrincipal/GrillaPrincipal/Data").jugadores["fighter"]


func data():
	return data

func _ready():
	pass # Replace with function body.

func coste_de_movimiento(tile_name):
	var coste = 1000
	if self.data["coste_movimiento"].has(tile_name):
		coste = self.data["coste_movimiento"][tile_name]
	
	return coste

#Funcion que se ejecuta cuando clickean al jugador
func _on_jugador_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && !event.is_pressed():
		orquestador.click_en_jugador(self)
