class_name ScaleZone extends Area2D

var scale_factor: float

func _ready():
	# Subscribe signals
	body_entered.connect(_on_body_entered_scale_zone)


func _on_body_entered_scale_zone(body: Node2D):
	if body is ScalableObject:
		scale_object(body)


func scale_object(body: ScalableObject):
	body.scale_by_factor(scale_factor)
