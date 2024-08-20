class_name ScalePlatform extends Node2D
# I think the solution is to have a weight area exit and weight area enter
@onready var weight_area = $MoveableObjects/WeightArea
@onready var ding_sound = $DingSound
@onready var error_sound = $ErrorSound
@onready var scale_weight_display = $ScaleGoalWeightLabel
@onready var moveable_objects = $MoveableObjects

signal scale_goal_hit()
signal scale_goal_lost()

@export var goal_weight: float
var goal_has_been_hit: bool = false

# TODO - delete these eventually
var starting_scale_position: Vector2 = Vector2(0, -11) # -11
var finished_scale_position: Vector2 = Vector2(0, 5) # 5 #16 steps
var current_weight: float = 0.0:
	set(value):
		if value == goal_weight and not goal_has_been_hit:
			scale_goal_hit.emit()
			goal_has_been_hit = true
			play_goal_hit_effects()
		elif goal_has_been_hit:
			goal_has_been_hit = false
			scale_goal_lost.emit()
			play_goal_lost_effects()
		current_weight = value

func _ready():
	scale_weight_display.set("theme_override_colors/font_color", Color.ORANGE_RED)
	weight_area.connect("area_weight_changed", on_area_weight_changed)

func on_area_weight_changed(weight: float):
	current_weight = weight
	await get_tree().create_timer(.1).timeout
	var percentage: float = current_weight / goal_weight
	var step: float = 16.0 * percentage
	var tween_position: Tween = create_tween()
	print("The scale is this percentage of the way there")
	print(percentage)
	print("the scale is now at this position")
	print(Vector2(0, step+-16))
	tween_position.tween_property(moveable_objects, "position", Vector2(0, step+-11), 0.5)

func play_goal_hit_effects():
	scale_weight_display.set("theme_override_colors/font_color", Color.LIME_GREEN)
	await get_tree().create_timer(.1).timeout
	ding_sound.pitch_scale = randf_range(0.95, 1.2)
	ding_sound.play()

func play_goal_lost_effects():
	scale_weight_display.set("theme_override_colors/font_color", Color.ORANGE_RED)
	await get_tree().create_timer(.1).timeout
	error_sound.play()
	
