extends Node

func calcular_danio_defensa(actor_ataque : Node2D, actor_defensa : Node2D):
	print("atacando con:")
	print(actor_ataque.get_unidad().get_tipo())

	var danio = 0
	var ataques = actor_ataque.get_unidad().get_ataque()
	var defensa = actor_defensa.get_unidad().get_defensa()
	var modificadores_ataque = actor_ataque.get_unidad().get_modificador_ataque()
	var modificadores_defensa = actor_defensa.get_unidad().get_modificador_defensa()
	var chance_ataque = tirar_dado(3)

	var ataque_final = 0
	if(chance_ataque == 1):
		ataque_final = ataques.minimo
	elif(chance_ataque == 2):
		ataque_final = ataques.medio
	elif(chance_ataque == 3):
		ataque_final = ataques.maximo

	var modificador_ataque = modificadores_ataque[actor_defensa.get_unidad().get_tipo()]
	var modificador_defensa = modificadores_defensa[actor_ataque.get_unidad().get_tipo()]
	
	print("ataque final:")
	print(chance_ataque)
	print(ataque_final)
	print("modificador ataque:")
	print(modificador_ataque)
	print("modificador defensa:")
	print(modificador_defensa)
	print("defensa:")
	print(defensa)
	danio = ataque_final + modificador_ataque - modificador_defensa - defensa
	
	if actor_ataque.get_unidad().get_tipo() == "arquero" and danio <= 0:
		danio = 1
		print("danio:")
		print(danio)
		return danio
	elif danio > 0:
		print("danio:")
		print(danio)
		return danio
	else:
		print("danio:")
		print("danio igual a 0")
		return 0
	
	
func tirar_dado(caras):
	var tirada = randi() % (caras) + 1
	return tirada

func calcular_danio_ataque(actor_ataque : Node2D, actor_defensa : Node2D):
	var danio = 0
	return danio

