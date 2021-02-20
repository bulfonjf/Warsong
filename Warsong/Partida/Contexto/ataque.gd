extends Node

func calcular_danio_defensa(actor_ataque : Node2D, actor_defensa : Node2D):
	print("atacando con:")
	var danio = 0
	var ataque = 0
	var ataque_dados = 0
	var ataque_dados_modificador = 0
	var dados_ataque = actor_ataque.get_unidad().get_ataque()
	var defensa = actor_defensa.get_unidad().get_defensa()
	var modificadores = actor_ataque.get_unidad().get_modificadores()
	var dados_modificador = actor_ataque.get_unidad().get_dado_modificador()
	var dados = dados_ataque["dados"]
	print("dados:")
	print(dados)
	var caras = dados_ataque["caras"]
	print("caras:")
	print(caras)
	var dado_modificador = dados_modificador["dados"]
	var caras_dado_modificador = dados_modificador["caras"]
	
	for dado in  dados :
		ataque_dados = tirar_dado(caras)
	print("tirada:")
	print(ataque_dados)
	for dado in dado_modificador:
		ataque_dados_modificador = tirar_dado(caras_dado_modificador)
	
	
	
	if actor_ataque.get_unidad().get_tipo() == "lancero":
		if actor_defensa.get_unidad().get_tipo() == "caballero":
			modificadores =+ 3
	if actor_ataque.get_unidad().get_tipo() == "caballero":
		if actor_defensa.get_unidad().get_tipo() == "fighter":
			modificadores =+ 3
	
	print("modificadores")
	print(modificadores)

	ataque = ataque_dados + ataque_dados_modificador + modificadores
	print("ataque total:")
	print(ataque)
	print("defensa:")
	print(defensa)
	if ataque > defensa:
		danio = ataque - defensa
		print("danio")
		print(danio)
		return danio
	else:
		print("danio")
		print(danio)
		return danio
	

func tirar_dado(caras):
	var tirada = randi() % (caras) + 1
	return tirada

func calcular_danio_ataque(actor_ataque : Node2D, actor_defensa : Node2D):
	print("contrataque con:")
	var danio = 0
	var ataque = 0
	var ataque_dados = 0
	var ataque_dados_modificador = 0
	var dados_ataque = actor_defensa.get_unidad().get_ataque()
	var defensa = actor_ataque.get_unidad().get_defensa()
	var modificadores = actor_defensa.get_unidad().get_modificadores()
	var dados_modificador = actor_defensa.get_unidad().get_dado_modificador()
	var dados = dados_ataque["dados"]
	print("dados:")
	print(dados)
	var caras = dados_ataque["caras"]
	print("caras:")
	print(caras)
	var dado_modificador = dados_modificador["dados"]
	var caras_dado_modificador = dados_modificador["caras"]
	
	if actor_ataque.get_unidad().get_tipo() == "arquero":
		print("es arquero, no recibe contrataque")
		return danio

	for dado in  dados :
		ataque_dados = tirar_dado(caras)
	print("tirada:")
	print(ataque_dados)

	for dado in dado_modificador:
		ataque_dados_modificador = tirar_dado(caras_dado_modificador)
	
	if actor_defensa.get_unidad().get_tipo() == "lancero":
		if actor_ataque.get_unidad().get_tipo() == "caballero":
			modificadores =+ 3
	if actor_defensa.get_unidad().get_tipo() == "caballero":
		if actor_ataque.get_unidad().get_tipo() == "fighter":
			modificadores =+ 3

	print("modificadores")
	print(modificadores)
		
	ataque = ataque_dados + ataque_dados_modificador + modificadores
	print("ataque total:")
	print(ataque)
	print("defensa:")
	print(defensa)
	
	if ataque > defensa:
		danio = ataque - defensa
		print("danio")
		print(danio)
		return danio

	else:
		print("danio")
		print(danio)
		return danio