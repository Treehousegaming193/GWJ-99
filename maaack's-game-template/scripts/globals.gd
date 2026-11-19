extends Node

# Constants
const NUZZLE_RATE: int = 10 # used in nuzzle_controller.gd
const BATTER_AMOUNT_FOR_CAKE: int = 20

#  Currency
var rock_currency: int = 50:
	set(value):
		rock_currency = clampi(value, 0, 50)
var tree_currency: int = 50:
	set(value):
		tree_currency = clampi(value, 0, 50)
var lava_currency: int = 50:
	set(value):
		lava_currency = clampi(value, 0, 50)
		
