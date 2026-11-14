extends Node2D



#func _on_area_2d_body_entered(body: Node2D) -> void:
	#if body.is_in_group("mouse"):
		#queue_free()


func _on_area_2d_mouse_entered() -> void:
	queue_free()
