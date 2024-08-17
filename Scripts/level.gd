class_name Level extends Node2D
@onready var balls_parent = $Balls

var balls: Array = []

func _ready():
	balls = balls_parent.get_children()
	for ball in balls:
		if ball is ScalableObject:
			ball.gravity_scale = 0


func _process(delta):
	if Input.is_action_just_pressed("start"):
		start_level()
		
		
func start_level():
	# Do some other fun effects here
	for ball in balls:
		if ball is ScalableObject:
			ball.gravity_scale = 0.5
