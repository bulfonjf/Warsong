extends Script

const posiciones = [Vector2(0,0), Vector2(1,0)]

const equipos= [
	{
		"nombre" : "equipo_1",
		"tropas": [
			{
				"posicion" : posiciones[0],
				"clase" : "fighter",
				"equipamiento" : ["pechera de cuero", "espada", "armadura de caballo"], #// ojo, usar los mismos nombres que items
			}
		]
	},
	{
		"nombre" : "equipo_2",
		"tropas": [
			{
				"posicion" : posiciones[1],
				"clase" : "caballero",
				"equipamiento" : ["pechera de cuero", "espada","armadura de caballo"], #// ojo, usar los mismos nombres que items
			}
		]
	}
 ]
