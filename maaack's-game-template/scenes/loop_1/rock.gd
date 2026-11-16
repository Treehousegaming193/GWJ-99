extends Node2D

@export var health:int = 5

func _ready() -> void:
	$ProgressBar.max_value = health
	$ProgressBar.value = health

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if visible:
		if $Click_delay.is_stopped():
			if event is InputEventMouseButton:
				$ProgressBar.visible = true
				health -= 1
				$ProgressBar.value -= 1
				$Click_delay.start()
				if health <= 0:
					globals.rock_currency += 1
					queue_free()
