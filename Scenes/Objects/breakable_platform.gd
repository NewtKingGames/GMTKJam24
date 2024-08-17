class_name BreakablePlatform extends StaticBody2D

signal platform_broke(platform: BreakablePlatform)

@onready var break_sound = $BreakSound
@onready var weight_area = $WeightArea

@export var weight_limit: float

var current_weight: float = 0.0:
	set(value):
		if value >= weight_limit:
			break_platform()
		current_weight = value

func _ready():
	weight_area.connect("area_weight_changed", on_area_weight_changed)

func on_area_weight_changed(weight: float):
	current_weight = weight

func break_platform():
	platform_broke.emit(self)
	queue_free()
