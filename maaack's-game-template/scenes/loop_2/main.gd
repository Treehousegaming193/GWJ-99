extends Node2D

# Nodes
@export var nuzzle_controller: Nuzzle
# UI
@export var switch_to_tree: Button
@export var switch_to_rock: Button
@export var switch_to_lava: Button
@export var release_nuzzle: Button

# -- BUILT INS -- #
func _ready() -> void:
	# default to tree
	switch_to_tree.button_pressed = true
	nuzzle_controller.currency_id = 1
	
	switch_to_tree.toggled.connect(_on_tree_pressed)
	switch_to_rock.toggled.connect(_on_rock_pressed)
	switch_to_lava.toggled.connect(_on_lava_pressed)
	release_nuzzle.toggled.connect(_on_release_nuzzle_pressed)

func _process(delta: float) -> void:
	if release_nuzzle.button_pressed:
		match nuzzle_controller.currency_id:
			1: 
				switch_to_rock.disabled = true
				switch_to_lava.disabled = true
			2: 
				switch_to_tree.disabled = true
				switch_to_lava.disabled = true
			3: 
				switch_to_tree.disabled = true
				switch_to_rock.disabled = true
				
	else:
		switch_to_tree.disabled = false
		switch_to_rock.disabled = false
		switch_to_lava.disabled = false
		
	
# -- CALLBACKS -- #
func _on_tree_pressed(_toggled_on: bool) -> void:
	nuzzle_controller.currency_id = 1

func _on_rock_pressed(_toggled_on: bool) -> void:
	nuzzle_controller.currency_id = 2

func _on_lava_pressed(_toggled_on: bool) -> void:
	nuzzle_controller.currency_id = 3

func _on_release_nuzzle_pressed(toggled_on: bool) -> void:
	if toggled_on:
		nuzzle_controller.release_nuzzle()
	else:
		nuzzle_controller.stop_nuzzle()
