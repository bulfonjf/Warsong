extends Node

onready var orquestador : Node2D = get_node("/root/NodoPrincipal")
onready var contenedor_horizontal : VBoxContainer = get_node("/root/NodoPrincipal/MenuLateral/Contenedor_H")
# Ready
func _ready():
	pass 

#Muestra el menu del jugador
#Llamada por orquestador.click_en_jugador(jugador)
func mostrar(posicion, adyacentes):
	self.rect_position = posicion
	self.visible = true
	contenedor_horizontal.boton_atacar(adyacentes)
	
#Oculta el menu:
func ocultar():
	self.visible = false
	


#Funcion que se ejecuta cuando se hace click en el boton "Mover"
func _on_Mover_pressed():
	orquestador.mostrar_movimiento_disponible()

func _on_Atacar_pressed():
	orquestador.atacar()
