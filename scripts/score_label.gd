extends Label
class_name ScoreLabel


var score: int = 0


func increment_score():
	score += 1
	text = str(score)


func _ready():
	score = 0
	text = str(score)
