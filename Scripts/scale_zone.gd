class_name ScaleZone extends Area2D


var scale_factor: float

func _ready():
	print("here!")
	# Subscribe signals
	body_entered.connect(_on_body_entered_scale_zone)


func _on_body_entered_scale_zone(body: Node2D):
	print(body)
	if body is ScalableObject:
		scale_object(body)


func scale_object(body: ScalableObject):
	print("object is scalable")
	body.scale_by_factor(scale_factor)
