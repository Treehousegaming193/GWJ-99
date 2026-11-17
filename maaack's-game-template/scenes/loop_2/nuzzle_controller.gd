class_name Nuzzle extends Node2D

# nodes
@export var cpu_particles_2d: CPUParticles2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var line_2d: Line2D

# sfx nodes
@export var nuzzle_open: AudioStreamPlayer
@export var nuzzle_close: AudioStreamPlayer
@export var nuzzle_hover: AudioStreamPlayer
@export var nuzzle_click: AudioStreamPlayer
@export var batter_pouring: AudioStreamPlayer

enum State { IDLE, RUNNING }
var _current_state: State = State.IDLE

signal nuzzle_empty
var _batter_amount: int



# -- PUBLIC METHODS -- #
func release_nuzzle() -> void:
	pass

func stop_nuzzle() -> void:
	pass

# -- STATE MACHINE -- #


# -- HELPERS -- #
func get_batter_amount() -> int:
	return 0

# -- BUILT-INS -- #
func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	pass
