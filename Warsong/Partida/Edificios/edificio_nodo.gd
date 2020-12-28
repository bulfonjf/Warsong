extends Node2D

var edificio_clase = load("res://Partida/Edificios/edificio_clase.gd")
var edificio : Edificio

func init(edificio_partida, posicion : Pixel):
	edificio = edificio_clase.new(edificio_partida)
	self.position = posicion.vector

func _ready():
	pass # Replace with function body.
