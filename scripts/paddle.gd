extends CharacterBody2D
class_name Paddle


@export var shorten_factor: float = 0.9
var screen_size: Vector2 = Vector2.ZERO
var half_height: float = 0.0
var can_move: bool = false
var start_position: Vector2 = Vector2.ZERO


func reset():
	can_move = false
	position = start_position


func clamp_y(y_pos: float):
	return clamp(y_pos, half_height, screen_size.y - half_height)


func shorten():
	# Reduce the height of the paddle
	scale.y *= shorten_factor
	half_height *= shorten_factor


func _ready():
	# Get size of Paddle
	screen_size = get_viewport().size
	# Determine half the height
	half_height = $Sprite2D.get_rect().size.y / 2
	# Initialize with movement disabled
	can_move = false
