extends Node
class_name ext_lista

func comparar_arrays(source : Array, target : Array) -> bool:
    var match = false
    for item in source:
        if target.has(item):
            match = true
        else:
            match = false
            break

    return match

