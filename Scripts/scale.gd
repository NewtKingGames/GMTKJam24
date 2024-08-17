class_name Scale extends StaticBody2D

# TODO - consider making this scene JUST the Area2D and we'll compose it with other scenes later
signal scale_weight_changed(weight: float)

#var objects_on_scale: Array[ScalableObject] = []
# I think this should be a map to make removing the item from the list easier
var objects_on_scale: Dictionary = {}
var current_weight: float = 0.0:
	set(value):
		current_weight = value
		scale_weight_changed.emit(current_weight)

func add_object_to_scale(object: ScalableObject):
	objects_on_scale[object.name] = object
	objects_on_scale_changed()
	
func remove_object_from_scale(object: ScalableObject):
	objects_on_scale.erase(object.name)
	objects_on_scale_changed()

func objects_on_scale_changed():
	current_weight = compute_weight_of_objects()
	print("the new current weight is")
	print(current_weight)

# TODO - do we need to trigger this after every scale change? probably not but worth thinking about
func compute_weight_of_objects() -> float:
	var total_weight: float = 0.0
	for object in objects_on_scale.values():
		if object is ScalableObject:
			print(object)
			total_weight += object.get_current_weight()
		else:
			print("something wrong somehow a non scalable object got into the scale")
	return total_weight


# TODO - slowdown the objects when they land on the scale!!!
func _on_scale_area_body_entered(body: Node2D):
	if body is ScalableObject:
		# This might cause issues if the object is the player? not sure
		body.linear_velocity = Vector2.ZERO
		add_object_to_scale(body)

func _on_scale_area_body_exited(body: Node2D):
	if body is ScalableObject:
		remove_object_from_scale(body)
