var pixel_script = preload("res://Scripts/pixel.gd")

func pixel(vector : Vector2) -> Pixel:
	return pixel_script.new(vector)
