extends TextEdit

signal updatear_ip
var _ignore

func _ready() -> void:
	self.text = "127.0.0.1"
	emit_signal("updatear_ip", self.text)
	pass

func obtener_texto():
	return self.get_text()

func _on_ip_servidor_text_changed():
	emit_signal("updatear_ip", self.text)

