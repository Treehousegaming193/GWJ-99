extends Label

func _process(delta: float) -> void:
	text = "Lava: "+str(globals.lava_currency)
