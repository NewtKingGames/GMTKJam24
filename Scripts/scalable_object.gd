extends PhysicsBody2D # Consider changing to rigidbody 2D if you have to
class_name ScalableObject

signal scale_changed(current_scale: float)

# This class should be added as the top level script of every object in the game it proveides things for:
# The current "scale" of the object which affects things like weight and size and maybe speed. The effects of size should be set in the classes which extend this
var current_scale: float
var base_weight: float

# TODO implement some kind of weight system with child classes implementing "base weight"

func scale_up():
	_change_scale(current_scale * 2)

func scale_down():
	_change_scale(current_scale * 0.5)

func scale_by_factor(scale_factor: float):
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
	print("parent class")
	pass
