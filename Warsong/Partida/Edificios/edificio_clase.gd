extends Reference

class_name Edificio

var nombre = ""
var faccion = ""
var modificadores = {}

func init(edificio):
    self.nombre = edificio.nombre
    self.faccion = edificio.faccion
    self.modificadores = edificio.modificadores

func set_faccion(faccion_nombre):
    self.faccion = faccion_nombre