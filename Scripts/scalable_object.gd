extends RigidBody2D # Consider changing to rigidbody 2D if you have to
class_name ScalableObject

# TODO - this will work better if the Ball scene inhertied from some base scene
@onready var grow_scale_particle_effect: ScaleParticleEffect = $GrowScaleParticleEffect
@onready var shrink_scale_particle_effect: ScaleParticleEffect = $ShrinkScaleParticleEffect

signal scale_changed(current_scale: float)

# This class should be added as the top level script of every object in the game it proveides things for:
# The current "scale" of the object which affects things like weight and size and maybe speed. The effects of size should be set in the classes which extend this
@export var current_scale: float
var base_weight: float

func scale_by_factor(scale_factor: float):
	# Start scale up or down effects
	if scale_factor > 1:
		grow_scale_particle_effect.start_particle_effects()
	elif scale_factor < 1:
		shrink_scale_particle_effect.start_particle_effects()
	grow_scale_particle_effect.change_scale_of_particle_effect(scale_factor)
	shrink_scale_particle_effect.change_scale_of_particle_effect(scale_factor)
	_change_scale(current_scale *  scale_factor)

# Consider putting this into a get/set?
func get_current_weight():
	return base_weight * current_scale

func _change_scale(scale_value: float):
	current_scale = scale_value
	update_scale_attributes()
	# Call other function to change things

# This needs to be implemented by each class that extends this
func update_scale_attributes():
	stop_scale_effects()

func finished_scaling_attributes():
	print("finished scaling attributes")
	stop_scale_effects()

func stop_scale_effects():
	grow_scale_particle_effect.stop_particle_effects()
	shrink_scale_particle_effect.stop_particle_effects()
