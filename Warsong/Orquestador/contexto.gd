extends Node


onready var data_contexto = {}
onready var contexto_unico = false
onready var finalizar_contexto = {}

func dispose():
	for metodo_a_ejecutar in finalizar_contexto.keys():
		var argumentos = finalizar_contexto[metodo_a_ejecutar]["argumentos"]
		finalizar_contexto[metodo_a_ejecutar]["funcion"].call_func(argumentos)
