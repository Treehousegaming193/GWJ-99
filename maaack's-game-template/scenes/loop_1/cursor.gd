extends Node2D

func _process(delta: float) -> void:
	position = get_global_mouse_position()


func _on_area_2d_body_entered(body: Node2D) -> void:
	body.queue_free()
