extends Area2D
class_name ScoreArea


# Create label object to populate via Inspector for any scenes that inherit
@export var score_label: ScoreLabel = null
# Create paddle object to populate via Inspector for any scenes that inherit
@export var paddle: Paddle = null


func increment_score():
	score_label.increment_score()
	paddle.shorten()
