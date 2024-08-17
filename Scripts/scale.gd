class_name Scale extends StaticBody2D

# TODO - consider making this scene JUST the Area2D and we'll compose it with other scenes later
signal scale_weight_changed(weight: float)
signal scale_goal_hit()
signal scale_goal_lost()


@export var goal_weight: float
# I think this should be a map to make removing the item from the list easier
var objects_on_scale: Dictionary = {}
var goal_has_been_hit: bool = false
var current_weight: float = 0.0:
	set(value):
		if value == goal_weight:
			goal_weight_hit()
		elif goal_has_been_hit:
			goal_weight_lost()
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

func compute_weight_of_objects() -> float:
	var total_weight: float = 0.0
	for object in objects_on_scale.values():
		if object is ScalableObject:
			total_weight += object.get_current_weight()
		else:
			print("something wrong somehow a non scalable object got into the scale")
	return total_weight

func goal_weight_hit():
	scale_goal_hit.emit()

func goal_weight_lost():
	scale_goal_lost.emit()

# TODO - slowdown the objects when they land on the scale!!!
func _on_scale_area_body_entered(body: Node2D):
	if body is ScalableObject:
		# This might cause issues if the object is the player? not sure
		body.linear_velocity = Vector2.ZERO
		add_object_to_scale(body)

func _on_scale_area_body_exited(body: Node2D):
	if body is ScalableObject:
		remove_object_from_scale(body)
