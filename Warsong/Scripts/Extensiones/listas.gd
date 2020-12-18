extends Node
class_name ext_lista

func comparar_arrays(source : Array, target : Array) -> bool:
	var matcheo = false
	for item in source:
		if target.has(item):
			matcheo = true
		else:
			matcheo = false
			break

	return matcheo

