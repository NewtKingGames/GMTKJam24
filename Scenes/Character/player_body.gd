class_name Player extends ScalablePlayer
@onready var sprite_2d = $Sprite2D
@onready var pickup_slot_marker = $PickupSlotMarker
@onready var pickup_area = $PickupArea
@onready var putdown_marker = $PutdownMarker
@onready var floor_detector = $FloorDetector

const SPEED = 600.0
const JUMP_VELOCITY = -900.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity = 2000

func _physics_process(delta):
	# Flip the sprite depending on direction:
	if velocity.x > 0 :
		sprite_2d.flip_h = false
		pickup_area.scale.x = 1
		pickup_slot_marker.position.x = -9.75
		putdown_marker.position.x = 27.75
	if velocity.x < 0:
		sprite_2d.flip_h = true
		pickup_area.scale.x = -1
		pickup_slot_marker.position.x = 9.75
		putdown_marker.position.x = -27.75
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if is_on_floor():
		# Grab the object that we're on
		var floor: Node2D = get_floor_object()
		if floor:
			rotation = floor.rotation
	else:
		rotation = 0
	move_and_slide()

func get_floor_object() -> Node2D:
	# Grab the object
	if floor_detector.get_overlapping_areas().size() > 0:
		return floor_detector.get_overlapping_bodies()[0]
	return null

# This needs to be implemented by each class that extends this
func update_scale_attributes():
	super.update_scale_attributes()
