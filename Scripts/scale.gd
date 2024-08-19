class_name WeightArea extends Area2D

signal area_weight_changed(weight: float)

@export var should_slowdown_objects: bool
# I think this should be a map to make removing the item from the list easier
var objects_on_area: Dictionary = {}
var goal_has_been_hit: bool = false
var current_weight: float = 0.0:
	set(value):
		current_weight = value
		area_weight_changed.emit(current_weight)

func add_object_to_scale(object: ScalableObject):
	object.connect("scale_changed", objects_on_scale_changed)
	objects_on_area[object.name] = object
	objects_on_scale_changed()

func remove_object_from_scale(object: ScalableObject):
	objects_on_area.erase(object.name)
	objects_on_scale_changed()

func objects_on_scale_changed():
	#print(" current weight is ")
	current_weight = compute_weight_of_objects()
	#print(current_weight)

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
	if body is ScalableObject and not is_object_on_scale(body):
		if should_slowdown_objects:
			body.linear_velocity = Vector2.ZERO
		add_object_to_scale(body)

func _on_scale_area_body_exited(body: Node2D):
	if body is ScalableObject:
		remove_object_from_scale(body)

func is_object_on_scale(body: Node2D):
	return objects_on_area.has(body.name)
