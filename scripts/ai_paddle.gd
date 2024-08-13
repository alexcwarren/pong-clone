extends Paddle


@export var SPEED: float = 100.0
var ball_position: Vector2 = Vector2.ZERO
var ball_velocity: Vector2 = Vector2.ZERO


func set_ball_info(pos: Vector2, vel: Vector2):
	# update AI paddle's awareness of ball position and velocity
	# (for following behavior in _physics_process function)
	ball_position = pos
	ball_velocity = vel


func is_ball_going_right(enabled: bool = true) -> bool:
	# if enabled, return if ball is movign rightward
	if enabled:
		return ball_velocity.normalized().x > 0
	# if disabled, return true and ignore condition
	# (this allows AI paddle to follow ball at all times)
	return true


func _init():
	start_position = Vector2(935, 270)
	reset()


func _physics_process(delta):
	# Keep AI paddle from moving along x-axis
	position.x = start_position.x
	
	if can_move and is_ball_going_right(false):
		# Assume AI paddle is moving in +ve y direction (down)
		var direction: int = 1
		
		# Determine if paddle should move in -ve y direction (up)
		if position.y > ball_position.y:
			direction = -1
		
		# Apply change in AI paddle's y position
		position.y += direction * SPEED * delta
		# Keep AI paddle from going beyond borders
		position.y = clamp_y(position.y)
