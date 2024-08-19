class_name Ball extends ScalableObject

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@onready var impact_sound = $ImpactSound
@onready var roll_sound = $RollSound


var sprite_starting_scale: Vector2
var collision_shape_starting_scale: Vector2

func _ready():
	base_weight = 4
	sprite_starting_scale = sprite_2d.scale
	collision_shape_starting_scale = collision_shape_2d.scale
	# Set all balls default scale to 1
	if current_scale == 0:
		current_scale = 1.0
	else:
		update_scale_attributes_instantly()

func update_scale_attributes():
	_update_scale_attributes(Globals.scale_duration)

func update_scale_attributes_instantly():
	_update_scale_attributes(0)

func _update_scale_attributes(duration: float):
	var tween_properties = create_tween()
	tween_properties.parallel().tween_property(sprite_2d, "scale", sprite_starting_scale* current_scale, duration)
	await tween_properties.parallel().tween_property(collision_shape_2d, "scale", collision_shape_starting_scale*current_scale, duration).finished
	super.update_scale_attributes() # Calling parent class stops the particle effects immediaetly
