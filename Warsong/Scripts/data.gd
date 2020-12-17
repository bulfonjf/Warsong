extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

export var terrenos = {
	'pasto': {
		'tipo': 'tierra'
	},
	'ruta': {
		'tipo': 'camino'
	},
	"bosque":{
		"tipo" : "bosque"
	},
	"mar":{
		"tipo" : "agua"
	},
	"oceano":{
		"tipo" : "aguas_profundas"
	},
	"empty":{
		"tipo" : "empty"
	}
}

export var jugadores = {
	"fighter" : {
		"coste_movimiento" : {
			"tierra" : 2,
			"camino" : 1,			 
		},
		"movimientos" : 7,
		"ataque" : 11,
		"defensa" : 1,
		"vida" : 50
	}
}
