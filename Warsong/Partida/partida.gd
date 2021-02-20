extends Reference

const posiciones_unidades = [Vector2(0,2), Vector2(0,3)]
const posiciones_edificios = [Vector2(3,4), Vector2(4,2), Vector2(5,2), Vector2(6,2)] 

const edificios = [
	{
		"nombre": "base",
		"posicion": posiciones_edificios[0],
		"faccion": "orcos"
	},
	{
		"nombre": "aserradero",
		"posicion": posiciones_edificios[1],
		"faccion": "orcos"
	},
	{
		"nombre": "cantera",
		"posicion": posiciones_edificios[2],
		"faccion": "orcos"
	},
	{
		"nombre": "mina_de_oro",
		"posicion": posiciones_edificios[3],
		"faccion": "orcos"
	}
]

const facciones = [
	{
		"nombre" : "orcos",
		"tropas": ["fighter", "caballero", "arquero"],
		"modificadores": {
						"ataque" : 1,
						"critico" : 5,
						}
	},
	{
		"nombre" : "elfos",
		"tropas": ["fighter", "caballero", "arquero"],
		"modificadores": {
						"defensa" : 1,
						"esquiva" : 5,
						}
	}
 ]

static func obtener_facciones():
	return facciones
