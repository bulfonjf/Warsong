extends "res://UI/Componentes/categoria.gd"

#Menu lateral mapa llama a esta funcion, le pasa el actor activo.
func init_unidad(unidad : Unidad):
	var titulo = unidad.clase.nombre
	var dic = {
		"faccion": unidad.obtener_faccion(),
		"vida": unidad.vida,
		#"ataque": str(str(unidad.get_ataque()["dados"])+ "d" +str(unidad.get_ataque()["caras"])),
		"defensa": unidad.get_defensa(),
		#"critico" : unidad.get_ataque_critico(),
		#"esquiva": unidad.get_esquiva(),
		#"items": "",
		"mov": unidad.get_movimientos()

	}
	self.init_categoria(dic, titulo)

func _ready():
	pass
