class_name Level extends Node2D
@onready var balls_parent = $Balls
@onready var weight_scale_tracker = $WeightScaleTracker
@onready var label = $Label

var balls: Array = []

func _ready():
	balls = balls_parent.get_children()
	for ball in balls:
		if ball is ScalableObject:
			ball.gravity_scale = 0
	weight_scale_tracker.connect("all_scale_goals_hit", beat_level)


func _process(delta):
	if Input.is_action_just_pressed("start"):
		start_level()
	if Input.is_action_just_pressed("Reset"):
		restart_level()
		
		
func start_level():
	# Do some other fun effects here
	for ball in balls:
		if ball is ScalableObject:
			ball.gravity_scale = 0.5

func beat_level():
	label.visible = true

func restart_level():
	get_tree().reload_current_scene()
