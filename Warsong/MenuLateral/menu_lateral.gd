extends Node

onready var orquestador : Node2D = get_node("/root/NodoPrincipal")

# Ready
func _ready():
	pass 

#Funciones que muestran y ocultan el menu
#Llamada por orquestador.click_en_jugador(jugador)
func mostrar(posicion):
	self.rect_position = posicion
	self.visible = true
#Llamada por self._on_NodoPrincipal_finalizado():
func ocultar():
	self.visible = false


#Funcion que se ejecuta cuando se hace click en el boton "Mover"
func _on_Mover_pressed():
	orquestador.mostrar_movimiento_disponible()
	
#Funcion que se ejecuta con señal "finalizado"->[orquestador.mover_actor_actual()]
#oculta el menu despues de que se se ejecuta (¿o no?) el movimiento.
func _on_NodoPrincipal_finalizado():
	self.ocultar()
	pass 
