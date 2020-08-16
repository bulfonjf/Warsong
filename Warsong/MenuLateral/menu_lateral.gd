extends Node

onready var orquestador : Node2D = get_node("/root/NodoPrincipal")

# Ready
func _ready():
	pass 

#Muestra el menu del jugador
#Llamada por orquestador.click_en_jugador(jugador)
func mostrar(posicion):
	self.rect_position = posicion
	self.visible = true
	
	
#Oculta el menu:
func ocultar():
	self.visible = false


#Funcion que se ejecuta cuando se hace click en el boton "Mover"
func _on_Mover_pressed():
	orquestador.mostrar_movimiento_disponible()
