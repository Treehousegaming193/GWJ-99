extends Node2D

var count_down = 5

func _ready() -> void:
	$ProgressBar.value = 5

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if $Click_delay.is_stopped():
		if event is InputEventMouseButton:
			$ProgressBar.visible = true
			count_down -= 1
			$ProgressBar.value -= 1
			$Click_delay.start()
			if count_down <= 0:
				globals.rock_currency += 1
				queue_free()
