extends CharacterBody2D
class_name Ball


const MIN_VELOCITY: Vector2 = Vector2(-2000, -2000)
const MAX_VELOCITY: Vector2 = -MIN_VELOCITY
const SPEED: float = 500.0
const SPEED_INCREASE_RATE: float = 1.2

var start_position: Vector2 = Vector2.ZERO
var can_move: bool = false


func get_rand_angle() -> float:
	# Create random integer to determine left/right direction
	var rand_int: int = randi_range(1, 10)
	
	# PI*5/4 ⎺⎻⎼⎽           PI/-2          ⎽⎼⎻⎺ PI/-4
	#           ⎺⎻⎼⎽          |         ⎽⎼⎻⎺
	#              ⎺⎻⎼⎽       |      ⎽⎼⎻⎺
	#                 ⎺⎻⎼⎽    |   ⎽⎼⎻⎺
	# PI - - - - - - - - (Ball) - - - - - - - - 0
	#                 ⎽⎼⎻⎺    |   ⎺⎻⎼⎽
	#              ⎽⎼⎻⎺       |      ⎺⎻⎼⎽
	#           ⎽⎼⎻⎺          |         ⎺⎻⎼⎽
	# PI*3/4 ⎽⎼⎻⎺           PI/2           ⎺⎻⎼⎽ PI/4
	
	# If even, ball goes right
	if rand_int % 2 == 0:
		return randf_range(PI/-4, PI/4)
	return randf_range(PI*3/4, PI*5/4)


func move():
	# Enable ball to move
	can_move = true


func _init():
	# Initialize instance variables
	start_position = Vector2(480, 270)
	position = start_position
	# Disable Ball moving until game has started
	can_move = false
	
	# Set initial random velocity vector
	var angle: float = get_rand_angle()
	velocity.x = SPEED * cos(angle)
	velocity.y = SPEED * sin(angle)


func _physics_process(delta):
	# Only check for collision (and move the ball) if enabled to do so
	if can_move:
		var collision_object: KinematicCollision2D = move_and_collide(velocity * delta)
	
		# If collision occured
		# (collision_object is "truthy", i.e. evaluates to "true", only if Ball collided)
		if collision_object:
			# Bounce/Reflect
			var normal: Vector2 = collision_object.get_normal()
			velocity = velocity.bounce(normal)
			# normal values for each possible collision_object:
			# (0, -1) -> Bottom border
			# (1, 0) --> Player paddle
			# (0, 1) --> Top border
			# (-1, 0) -> AI paddle
			
			# If Ball collided with a Paddle (normal.y is 0 only for paddle collisions)
			if normal.y == 0:
				velocity *= SPEED_INCREASE_RATE
				# Keep velocity from getting too fast
				velocity = clamp(velocity, MIN_VELOCITY, MAX_VELOCITY)
