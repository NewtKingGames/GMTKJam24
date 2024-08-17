class_name WeightArea extends Area2D

# TODO - consider making this scene JUST the Area2D and we'll compose it with other scenes later
signal area_weight_changed(weight: float)
# I think this should be a map to make removing the item from the list easier
var objects_on_area: Dictionary = {}
var goal_has_been_hit: bool = false
var current_weight: float = 0.0:
	set(value):
		current_weight = value
		area_weight_changed.emit(current_weight)

func add_object_to_scale(object: ScalableObject):
	objects_on_area[object.name] = object
	objects_on_scale_changed()
	
func remove_object_from_scale(object: ScalableObject):
	objects_on_area.erase(object.name)
	objects_on_scale_changed()

func objects_on_scale_changed():
	current_weight = compute_weight_of_objects()

func compute_weight_of_objects() -> float:
	var total_weight: float = 0.0
	for object in objects_on_area.values():
		if object is ScalableObject:
			total_weight += object.get_current_weight()
		else:
			print("something wrong somehow a non scalable object got into the scale")
	return total_weight

# TODO - slowdown the objects when they land on the scale!!!
func _on_scale_area_body_entered(body: Node2D):
	# TODO - need to change this so it doesn't always happen i.e. on breakable platform
	if body is ScalableObject:
		# This might cause issues if the object is the player? not sure
		body.linear_velocity = Vector2.ZERO
		add_object_to_scale(body)

func _on_scale_area_body_exited(body: Node2D):
	if body is ScalableObject:
		remove_object_from_scale(body)
