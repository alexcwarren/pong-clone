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

		if collision_object:
			var collider = collision_object.get_collider()
			var normal = collision_object.get_normal()

			if collider is Paddle:
				# Always send the ball away from the paddle.
				var horizontal_direction = sign(global_position.x - collider.global_position.x)

				velocity.x = abs(velocity.x) * horizontal_direction
				velocity *= SPEED_INCREASE_RATE
				velocity = clamp(velocity, MIN_VELOCITY, MAX_VELOCITY)

				# Push the ball away so it doesn't remain touching the paddle.
				position.x += horizontal_direction * 4.0
			else:
				# Top/bottom wall collision.
				velocity = velocity.bounce(normal)
