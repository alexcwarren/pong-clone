extends Paddle


func _init():
	start_position = Vector2(25, 270)
	reset()


func _physics_process(_delta):
	if can_move:
		# Have Player paddle follow y-positition of mouse cursor
		# (while staying within borders of game window)
		position.y = clamp_y(get_viewport().get_mouse_position().y)
