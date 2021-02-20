extends KinematicBody2D


onready var id = "Garett_" + str(RandomNumberGenerator.new())
var unidad_clase = load("res://Partida/Unidades/unidad_clase.gd")
onready var control_vida : Control = load("res://UI/Control_Vida.tscn").instance()
onready var sprite = $Sprite
var unidad : Unidad
enum tropas {fighter, caballero, arquero, lancero}
enum facciones {orcos, elfos, humanos}
 
func get_unidad() -> Unidad:
	return unidad

func init(tropa, equipo):
	unidad = unidad_clase.new(tropa, equipo)
	
	
func _ready():
	sprite.set_frame_coords(Vector2(facciones[self.unidad.obtener_faccion()], tropas[self.unidad.clase.nombre]))
	self.add_child(control_vida)
	control_vida.iniciar(self.unidad)
	
	pass 
func actualizar_vida(danio : int):
	self.unidad.actualizar_vida(danio)
	self.control_vida.actualizar_vida(unidad)
	if self.unidad.vida < 1:
		queue_free()
		

func actualizar_movimiento(_coste_movimiento):
	self.unidad.actualizar_movimiento(_coste_movimiento)

func mover(posicion : Pixel):
	self.position = posicion.vector
	self.control_vida.actualizar_posicion()
	
func obtener_info():
	return unidad

func animar():
	$AnimationPlayer.play("caminar")

func desactivar_ataque():
	self.unidad.desactivar_ataque()

func actualizar_unidad_por_turno(_total_rondas):
	self.unidad.activar_ataque()
	self.unidad.set_movimientos(self.unidad.clase.nombre)
	pass

func get_faccion():
	return self.unidad.obtener_faccion()

func aplicar_modificadores(_modificadores):
	for modificador in _modificadores:
		pass