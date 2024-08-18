class_name ScalePlatform extends StaticBody2D
@onready var weight_area = $WeightArea
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@onready var scale_weight_display = $ScaleWeightDisplay

signal scale_goal_hit()
signal scale_goal_lost()

@export var goal_weight: float
var goal_has_been_hit: bool = false
var current_weight: float = 0.0:
	set(value):
		if value == goal_weight:
			scale_goal_hit.emit()
			play_goal_hit_effects()
		elif goal_has_been_hit:
			scale_goal_lost.emit()
		current_weight = value

func _ready():
	scale_weight_display.set("theme_override_colors/font_color", Color.ORANGE_RED)
	weight_area.connect("area_weight_changed", on_area_weight_changed)

func on_area_weight_changed(weight: float):
	current_weight = weight

func play_goal_hit_effects():
	scale_weight_display.set("theme_override_colors/font_color", Color.LIME_GREEN)
	await get_tree().create_timer(.1).timeout
	audio_stream_player_2d.play()	
