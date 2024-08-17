class_name Ball extends ScalableObject
@onready var sprite_2d = $Sprite2D
@onready var collision_shape_2d = $CollisionShape2D

var sprite_starting_scale: Vector2
var collision_shape_starting_scale: Vector2

func _ready():
	current_scale = 1.0
	sprite_starting_scale = sprite_2d.scale
	collision_shape_starting_scale = collision_shape_2d.scale

func update_scale_attributes():
	print("updating attributes!")
	print(current_scale)
	var tween_properties = create_tween()
	tween_properties.parallel().tween_property(sprite_2d, "scale", sprite_starting_scale* current_scale, Globals.scale_duration)
	tween_properties.parallel().tween_property(collision_shape_2d, "scale", collision_shape_starting_scale*current_scale, Globals.scale_duration)
