class_name ScalePlatform extends StaticBody2D
@onready var scale_area = $ScaleArea

signal scale_goal_hit()
signal scale_goal_lost()

@export var goal_weight: float
var goal_has_been_hit: bool = false
var current_weight: float = 0.0:
	set(value):
		if value == goal_weight:
			scale_goal_hit.emit()
		elif goal_has_been_hit:
			scale_goal_lost.emit()
		current_weight = value

func _ready():
	scale_area.connect("area_weight_changed", on_area_weight_changed)


func on_area_weight_changed(weight: float):
	current_weight = weight
