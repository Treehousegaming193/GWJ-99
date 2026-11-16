extends Node2D

@onready var tree: Resource = preload("res://scenes/loop_1/tree.tscn")

func _on_spawn_timer_timeout() -> void:
	var tree_instance: Node = tree.instantiate()
	add_child(tree_instance)
	var point_1:Vector2 = $spawn_1.position 
	var point_2:Vector2 = $spawn_2.position
	var spawn_location = get_random_point(point_1, point_2)
	tree_instance.set_position(spawn_location)

func get_random_point(point1: Vector2, point2: Vector2) -> Vector2:
	var x_value:float = randf_range(point1.x, point2.x)

	var y_value:float = randf_range(point1.y, point2.y)
	var random_point: Vector2 = Vector2(x_value, y_value)
	return(random_point)
