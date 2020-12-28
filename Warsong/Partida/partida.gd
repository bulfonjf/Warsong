extends Script

const posiciones_unidades = [Vector2(0,0), Vector2(1,0)]
const posiciones_edificios = [Vector2(3,1), Vector2(4,0), Vector2(5,0), Vector2(6,0)] 

const edificios = [
	{
		"nombre": "base",
		"posicion": posiciones_edificios[0],
		"faccion": ""
	},
	{
		"nombre": "aserradero",
		"posicion": posiciones_edificios[1],
		"faccion": ""
	},
	{
		"nombre": "cantera",
		"posicion": posiciones_edificios[2],
		"faccion": ""
	},
	{
		"nombre": "mina_de_oro",
		"posicion": posiciones_edificios[3],
		"faccion": ""
	}
]

const facciones = [
	{
		"nombre" : "orcos",
		"tropas": [
			{
				"posicion" : posiciones_unidades[0],
				"clase" : "fighter",
				"equipamiento" : ["pechera de cuero", "espada", "armadura de caballo"], #// ojo, usar los mismos nombres que items
			}
		]
	},
	{
		"nombre" : "elfos",
		"tropas": [
			{
				"posicion" : posiciones_unidades[1],
				"clase" : "caballero",
				"equipamiento" : ["pechera de cuero", "espada","armadura de caballo"], #// ojo, usar los mismos nombres que items
			}
		]
	}
 ]
