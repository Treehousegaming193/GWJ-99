extends Node2D

func _on_surface_button_button_down() -> void:
	$Cave.visible = false
	$Core.visible = false
	$Surface.visible = true

func _on_cave_button_button_down() -> void:
	$Surface.visible = false
	$Core.visible = false
	$Cave.visible = true

func _on_core_button_button_down() -> void:
	$Surface.visible = false
	$Cave.visible = false
	$Core.visible = true
