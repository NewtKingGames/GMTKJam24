class_name BreakablePlatform extends StaticBody2D

signal platform_broke(platform: BreakablePlatform)
@onready var collision_shape_2d = $CollisionShape2D
@onready var break_sound = $BreakSound
@onready var weight_area = $WeightArea
@onready var sprite_2d = $Sprite2D

@export var weight_limit: float

var current_weight: float = 0.0:
	set(value):
		print("weight is being set to")
		print(value)
		if value >= weight_limit:
			break_platform()
		current_weight = value

func _ready():
	weight_area.connect("area_weight_changed", on_area_weight_changed)

func on_area_weight_changed(weight: float):
	current_weight = weight

func break_platform():
	platform_broke.emit(self)
	collision_shape_2d.set_deferred("disabled", true)
	sprite_2d.visible = false
	break_sound.play()
	await get_tree().create_timer(1.3).timeout
	queue_free()
