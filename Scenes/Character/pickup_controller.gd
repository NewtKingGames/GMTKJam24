class_name PickupController extends Node2D
@onready var pickup_area = $"../PickupArea"
@onready var pickup_slot_marker = $"../PickupSlotMarker"
@onready var putdown_marker = $"../PutdownMarker"
@onready var player_body = $".."

@onready var scale_zone_put_down_highlight = $"../ScaleZonePutDownHighlight"


# if you find theres too many objects in the pickup area you could always try a more indepth algorithm with measuring distances
var object_in_pickup_area: ScaleZone = null
var object_picked_up: ScaleZone = null


func _ready():
	scale_zone_put_down_highlight.visible = false

func _process(delta):
	if Input.is_action_just_pressed("pickput"):
		if object_picked_up:
			place_object()
		elif object_in_pickup_area:
			pickup_object()
	if object_picked_up:
		object_picked_up.position = pickup_slot_marker.global_position
		object_picked_up.rotation = player_body.rotation
		scale_zone_put_down_highlight.global_position = putdown_marker.global_position


func pickup_object():
	object_picked_up = object_in_pickup_area
	object_in_pickup_area = null
	scale_zone_put_down_highlight.visible = true
	scale_zone_put_down_highlight.scale = object_picked_up.scale

func place_object():
	object_picked_up.position = scale_zone_put_down_highlight.global_position
	object_picked_up = null
	scale_zone_put_down_highlight.visible = false

func _on_pickup_area_area_entered(body: Area2D):
	if body is ScaleZone:
		object_in_pickup_area = body
		object_in_pickup_area.start_selectable_effects()
	
func _on_pickup_area_area_exited(body: Area2D):
	if body == object_in_pickup_area:
		object_in_pickup_area.stop_selectable_effects()
		object_in_pickup_area = null
	else:
		print("we hit the edge case check this out")
