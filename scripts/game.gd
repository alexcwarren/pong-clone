extends Node


const BallObj: PackedScene = preload("res://scenes/ball.tscn")

@export var WINNING_SCORE: int = 10
var ball: Ball = null
var game_started: bool = false
var game_ended: bool = false

var player_paddle: Paddle = null
var ai_paddle: Paddle = null
var player_score_label: ScoreLabel = null
var ai_score_label: ScoreLabel = null
var player_score_area: ScoreArea = null
var ai_score_area: ScoreArea = null
var winner_label: Label = null


func add_ball():
	# Add new Ball instance to Game
	ball = BallObj.instantiate()
	call_deferred("add_child", ball)


func reset():
	reset_paddles()
	# Remove Ball instance
	ball.queue_free()
	add_ball()
	game_started = false


func reset_paddles():
	# Reset paddle positions and any other values
	player_paddle.reset()
	ai_paddle.reset()


func enable_paddles():
	# Enable paddles to move
	player_paddle.can_move = true
	ai_paddle.can_move = true


func start():
	game_started = true
	enable_paddles()
	# Enable ball to move
	ball.move()


func increment_score(score_area: ScoreArea):
	score_area.increment_score()
	# Reset game (NOT restart) for next round
	reset()


func announce_winner():
	var winner: String = "Player"
	if player_score_label.score < ai_score_label.score:
		winner = "AI"
	winner_label.text = "The %s wins!" % winner
	winner_label.visible = true


func restart():
	# Restart game
	get_tree().reload_current_scene()


func _ready():
	# Instantiate game nodes
	player_paddle = $Paddles/PlayerPaddle
	ai_paddle = $Paddles/AIPaddle
	player_score_label = $Scores/PlayerScoreLabel
	ai_score_label = $Scores/AIScoreLabel
	player_score_area = $ScoreAreas/PlayerScoreArea
	ai_score_area = $ScoreAreas/AIScoreArea
	winner_label= $Winner
	
	add_ball()


func _process(_delta):
	# Check for win/lose condition
	if player_score_label.score >= WINNING_SCORE or ai_score_label.score >= WINNING_SCORE:
		reset_paddles()
		game_ended = true
		announce_winner()


func _physics_process(_delta):
	# Update AI paddle with ball position and velocity
	ai_paddle.set_ball_info(ball.global_position, ball.velocity)


func _input(event: InputEvent):
	# Start game if "Space", "Enter", etc. are pressed
	if not game_started:
		if event.is_action_pressed("ui_accept"):
			start()
	# If win/lose condition has been triggered, check to restart game
	if game_ended:
		if event.is_action_pressed("ui_accept"):
			restart()


# Trigger _score_area_body_entered signal only if body is a Ball instance:
# - Ball is on Layers 1 & 2 by enabling Collision Layers 1 & 2 for Ball only
# - Player & AI score areas check for collisions from Layer 2 only
#   by having only Collision Mask 2 enabled
# - All other collidable objects (borders/paddles) are just on Layer & Mask 1

func _on_player_score_area_body_entered(_body):
	# Signal that's triggered when body enters PlayerScoreArea
	increment_score(player_score_area)


func _on_ai_score_area_body_entered(_body):
	# Signal that's triggered when body enters AIScoreArea
	increment_score(ai_score_area)
