extends VBoxContainer

var key_value_component = load("res://UI/Componentes/KeyValue.tscn")
onready var titulo : Label = $Titulo

func init_categoria(dic : Dictionary, titulo_param):
	titulo.text = titulo_param
	for key in dic.keys():
		var item_ui = key_value_component.instance()
		self.add_child(item_ui)
		item_ui.init(str(key), str(dic[key]))

func _ready():
	pass 