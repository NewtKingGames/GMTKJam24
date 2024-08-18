class_name Level extends Node2D
@export var next_scene: PackedScene
@onready var balls_parent = $Balls
@onready var weight_scale_tracker = $WeightScaleTracker
@onready var label = $Label
@onready var zones_parent = $Zones


var balls: Array = []
var zones: Array = []

func _ready():
	zones = zones_parent.get_children()
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
	for zone in zones:
		zone.level_started()

func beat_level():
	label.visible = true
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_packed(next_scene)

func restart_level():
	get_tree().reload_current_scene()
