extends Label

func _process(delta: float) -> void:
	text = "Rock: "+str(globals.rock_currency)
