extends Label

func _process(delta: float) -> void:
	text = "Wood: "+str(globals.tree_currency)
