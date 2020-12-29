extends Control

onready var contenedor_horizontal : VBoxContainer = $Contenedor_H

# Ready
func _ready():
	pass 

signal mostrar_movimiento_disponible_signal()
signal atacar_signal()
signal borrar_signal()

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
	emit_signal("mostrar_movimiento_disponible_signal")

func _on_Atacar_pressed():
	emit_signal("atacar_signal")

func _on_Borrar_pressed():
	emit_signal("borrar_signal")
