# TODO:
# Make particles appear and disappear
# Make cake scene recieve objects

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

var _is_nuzzle_empty: bool = false
var _is_nuzzle_stopped: bool = true
var _tree_accum: float = 0.0
var _rock_accum: float = 0.0
var _lava_accum: float = 0.0
signal nuzzle_empty

var currency_id: int # 1: tree, 2: rock, 3: lava

# -- PUBLIC METHODS -- #
func release_nuzzle() -> void:
	_is_nuzzle_stopped = false
	
func stop_nuzzle() -> void:
	_is_nuzzle_stopped = true
	
# -- BUILT-INS -- #	
func _process(delta: float) -> void:
	#print("Tree", globals.tree_currency)
	if _is_nuzzle_empty:
		nuzzle_empty.emit()
	if not _is_nuzzle_stopped:
		match currency_id:
			1:	
				_tree_accum += delta * globals.NUZZLE_RATE
				var whole := int(_tree_accum)
				if whole > 0:
					_tree_accum -= whole
					globals.tree_currency = globals.tree_currency - whole
				print(globals.tree_currency)
			2:
				_rock_accum += delta * globals.NUZZLE_RATE
				var whole := int(_rock_accum)
				if whole > 0:
					_rock_accum -= whole
					globals.rock_currency = globals.rock_currency - whole
				print(globals.rock_currency)
			3:
				_lava_accum += delta * globals.NUZZLE_RATE
				var whole := int(_lava_accum)
				if whole > 0:
					_lava_accum -= whole
					globals.lava_currency = globals.lava_currency - whole
				print(globals.lava_currency)
		
