extends Script

const posiciones = [Vector2(0,0), Vector2(1,0)]

const equipos= [
	{
		"nombre" : "equipo_1",
		"tropas": [
			{
				"posicion" : posiciones[0],
				"clase" : "fighter"
			}
		]
	},
	{
		"nombre" : "equipo_2",
		"tropas": [
			{
				"posicion" : posiciones[1],
				"clase" : "fighter"
			}
		]
	}
 ]



const data = {
	"jugadores" : [
		{
			"tipo_jugador" : "fighter",
			"posicion_inicial" : posiciones[0],
			"grupos" : ["equipo1"]
		},
		{
			"tipo_jugador" : "fighter",
			"posicion_inicial" : posiciones[1],
			"grupos" : ["equipo2"]
		}
	]
}
