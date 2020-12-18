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

export var slots : Array = ["pecho", "mano_izquierda", "mano_derecha"]
export var clase_item : Array  = ["armadura_ligera", "armadura_pesada", "arma_dos_manos"]
export var items : Dictionary = {
		"pechera de cuero" : {
		"clases" : [clase_item[1]],
		"slots": [slots[0]], #// hardcodealo
		"modificadores": {
			"defensa_base" : 5,
			"movimiento" : -1,
			}
		}
	,
	
		"espada" : {
		"clases" : [clase_item[2]],
		"slots" : [slots[1], slots[2]], #// hardcodealo
		"modificadores": {
			"defensa_base" : 0,
			"ataque_base": 6,
			"movimiento" : 0,
			}
		}
	
}

export var clases_unidades : Dictionary = {
	"fighter" : {
		"coste_movimiento" : {
			"tierra" : 2,
			"camino" : 1,
			},
		"movimientos" : 7,
		"ataque" : 11,
		"defensa" : 1,
		"vida" : 50,
		"puede_equipar" : clase_item, #// ahora puede equipar todo, restringir despues
		"slots" : slots
	}
}
