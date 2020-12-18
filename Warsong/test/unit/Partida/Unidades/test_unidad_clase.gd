extends "res://addons/gut/test.gd"

func test_crear_unidad():
	var partida_data ={
				"clase" : "fighter",
				"equipamiento" : ["pechera de cuero", "espada"], #// ojo, usar los mismos nombres que items
			}

	var equipo = {}
	var unidad = load("res://Partida/Unidades/unidad_clase.gd").new(partida_data, equipo)
	assert_is(unidad, Unidad, "variable unidad no es de tipo Unidad")
	
func test_puede_equipar():
	var partida_data ={
				"clase" : "fighter",
				"equipamiento" : ["pechera de cuero", "espada"], #// ojo, usar los mismos nombres que items
			}

	var equipo = {}
	var unidad = load("res://Partida/Unidades/unidad_clase.gd").new(partida_data, equipo)

	assert_eq(unidad.equipamiento, partida_data.equipamiento)

func test_prueba():
	assert_true(true)
