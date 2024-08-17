class_name Scale extends StaticBody2D

#var objects_on_scale: Array[ScalableObject] = []
# I think this should be a map to make removing the item from the list easier
var objects_on_scale: Dictionary = {}
var current_weight: float = 0.0


func add_object_to_scale(object: ScalableObject):
	objects_on_scale[object.name] = object
	objects_on_scale_changed()
	
func remove_object_from_scale(object: ScalableObject):
	objects_on_scale.erase(object.name)
	objects_on_scale_changed()

func objects_on_scale_changed():
	current_weight = compute_weight_of_objects()

# TODO - do we need to trigger this after every scale change? probably not but worth thinking about
func compute_weight_of_objects() -> float:
	var total_weight: float = 0.0
	for object in objects_on_scale.values():
		if object is ScalableObject:
			print(object)
			#total_weight += object.get_weight()
		else:
			print("something wrong somehow a non scalable object got into the scale")
	return total_weight
