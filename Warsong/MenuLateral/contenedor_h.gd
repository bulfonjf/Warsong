extends VBoxContainer

onready var atacar : Button = get_node("/root/NodoPrincipal/MenuLateral/Contenedor_H/Atacar")


func _ready():
	
	
	pass # Replace with function body.

func boton_atacar (adyacentes):
	var tamanio_adyacentes = adyacentes.size()
	if tamanio_adyacentes > 0:
		atacar.visible = true
	else:
		atacar.visible = false
		
