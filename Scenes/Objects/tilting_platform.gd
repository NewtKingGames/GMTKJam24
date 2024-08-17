class_name TiltingPlatform extends StaticBody2D

@onready var right_weight_area = $RightWeightArea
@onready var left_weight_area = $LeftWeightArea

var right_weight: float = 0.0
var left_weight: float = 0.0

var max_rotation_left: float = -45.0
var max_rotation_right: float = 45.0
var rotation_change_rate

func _ready():
	right_weight_area.connect("area_weight_changed", _on_right_area_weight_changed)
	left_weight_area.connect("area_weight_changed", _on_left_area_weight_changed)


func _process(delta):
	if right_weight > left_weight:
		rotate_platform(1, delta)
	if left_weight > right_weight:
		rotate_platform(-1, delta)
	if right_weight == left_weight:
		# Rotate platform back to center slowly? This could be variant behavior between different types of tilting
		rotate_platform(0, delta)

# 1 spins clockwise -1 spins counter clockwise
func rotate_platform(direction: int, delta: float):
	if direction > 0:
		set_rotation_degrees(lerpf(rotation_degrees, max_rotation_right, 0.5 * delta))	
	elif direction < 0:
		set_rotation_degrees(lerpf(rotation_degrees, max_rotation_left, 0.5 * delta))
	else:
		set_rotation_degrees(lerpf(rotation_degrees, 0, 0.4 * delta))


func _on_right_area_weight_changed(weight: float):
	right_weight = weight

func _on_left_area_weight_changed(weight: float):
	print("weight changed!")
	left_weight = weight
