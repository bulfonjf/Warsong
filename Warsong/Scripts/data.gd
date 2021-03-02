extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

export var recursos = ["oro","puntos_de_tecnologia","madera","piedra"]
export var edificios = {
	"base": {
		"nombre": "base",
		"recursos_por_turno": {
			"puntos_de_tecnologia": 2
		}
	},
	"aserradero": {
		"nombre": "aserradero",
		"recursos_por_turno": {
			"madera": 4
		}
	},
	"cantera": {
		"nombre": "cantera",
		"recursos_por_turno": {
			"piedra": 1
		}
	}, 
	"mina_de_oro": {
		"nombre": "mina_de_oro",
		"recursos_por_turno": {
			"": 2
		}
	}, 
	"establos": {

	}, 
	"arqueria": {

	}, 
	"cuartel": {

	}
}
export var terrenos = {
	"pasto": {
		"tipo": "tierra"
	},
	"ruta": {
		"tipo": "camino"
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

export var slots : Array = ["pecho", "mano_izquierda", "mano_derecha", "caballo"]
export var clase_item : Array  = ["armadura_ligera", "armadura_pesada", "arma_dos_manos"]
export var items : Dictionary = {
	"pechera de cuero" : {
		"nombre": "pechera de cuero",
		"clases" : [clase_item[1]],
		"slots": ["pecho"], #// hardcodealo
		"modificadores": {
			"defensa_base" : 5,
			"movimiento" : -1,
		}
	},
	"espada" : {
		"nombre": "espada",
		"clases" : [clase_item[2]],
		"slots" : [slots[1], slots[2]], #// hardcodealo
		"modificadores": {
			"defensa_base" : 0,
			"ataque_base": 6,
			"movimiento" : 0,
		}
	},
	"armadura de caballo" : {
		"nombre": "armadura de caballo",
		"clases" : [clase_item[1]],
		"slots": ["caballo"], #// hardcodealo
		"modificadores": {
			"defensa_base" : 5,
			"movimiento" : -1,
		}
	}
}

export var clases_unidades : Dictionary = {
	"fighter" : {
		"nombre": "fighter",
		"coste_movimiento" : {
			"tierra" : 3,
			"camino" : 2,
			"bosque" : 3,
			},
		"ataque" : {
			"minimo" : 3,
			"medio"	: 5,
			"maximo": 7,
			},
		"modificador_ataque":{
			"fighter" : 0,
			"caballero"	: 0,
			"arquero": 0,
			"lancero": 2,
			}, 
		"modificador_defensa": {
			"fighter" : 0,
			"caballero"	: 0,
			"arquero": 0,
			"lancero": 2,
			}, 
		"defensa" : 3,
		"vida" : 6,
		"movimientos" : 7,

		"puede_equipar" : clase_item, #// ahora puede equipar todo, restringir despues
		"slots" : slots.slice(0,2)
	},
	"caballero" : {
		"nombre": "caballero",
		"coste_movimiento" : {
			"tierra" : 2,
			"camino" : 1,
			},
		"ataque" : {
			"minimo" : 3,
			"medio"	: 5,
			"maximo": 7,
			},
		"modificador_ataque":{
			"fighter" : 2,
			"caballero"	: 0,
			"arquero": 0,
			"lancero": 0,
			}, 
		"modificador_defensa": {
			"fighter" : 2,
			"caballero"	: 0,
			"arquero": 0,
			"lancero": 0,
			}, 
		"defensa" : 2,
		"vida" : 6,
		"movimientos" : 8,

		"puede_equipar" : clase_item, #// ahora puede equipar todo, restringir despues
		"slots" : slots
	},
	"arquero" : {
		"nombre": "arquero",
		"coste_movimiento" : {
			"tierra" : 3,
			"camino" : 2,
			"bosque" : 3,
			},
		"ataque" : {
			"minimo" : 3,
			"medio"	: 4,
			"maximo": 5,
			},
		"modificador_ataque":{
			"fighter" : 0,
			"caballero"	: 0,
			"arquero": 0,
			"lancero": 0,
			}, 
		"modificador_defensa": {
			"fighter" : 0,
			"caballero"	: 0,
			"arquero": 0,
			"lancero": 0,
			}, 
		"defensa" : 1,
		"vida" : 6,
		"movimientos" : 8,
		"puede_equipar" : clase_item, #// ahora puede equipar todo, restringir despues
		"slots" : slots
	},
	"lancero" : {
		"nombre": "lancero",
		"coste_movimiento" : {
			"tierra" : 3,
			"camino" : 2,
			"bosque" : 3,
			},
		"ataque" : {
			"minimo" : 2,
			"medio"	: 3,
			"maximo": 4,
			},
		"modificador_ataque":{
			"fighter" : 0,
			"caballero"	: 2,
			"arquero": 0,
			"lancero": 2,
			}, 
		"modificador_defensa": {
			"fighter" : 0,
			"caballero"	: 2,
			"arquero": 0,
			"lancero": 0,
			}, 
		"defensa" : 4,
		"vida" : 7,
		"movimientos" : 8,
	},
}

func obtener_unidades():
	return clases_unidades