extends Node2D

var edificio_clase = load("res://Partida/Edificios/edificio_clase.gd")
var edificio : Edificio

func init(edificio_data):
	edificio = edificio_clase.new(edificio_data)

func _ready():
	pass # Replace with function body.