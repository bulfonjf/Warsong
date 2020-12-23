class_name Faccion

var nombre : String
var recursos : Dictionary 
var tropas : Array

func _init(partida_data):
    self.nombre = partida_data.nombre
    
func agregar_tropa(tropa):
    tropas.append(tropa)