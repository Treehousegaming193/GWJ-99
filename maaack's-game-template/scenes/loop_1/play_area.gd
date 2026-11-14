extends Node2D

var rock: PackedScene = "res://scenes/loop_1/rock.tscn"

func _on_spawn_timer_timeout() -> void:
	var spawn_pos_x = randi_range(-2493.0, -60)
	var spawn_pos_y = randi_range(-226, 256)
	
