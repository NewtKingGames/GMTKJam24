class_name ScaleZone extends Area2D

@onready var point_light_2d = $PointLight2D
@onready var lock_icon_sprite = $LockIconSprite
@onready var error_sound = $ErrorSound
@onready var click_sound = $ClickSound

var scale_factor: float
# Set this to true to prevent the player from moving it and render a small lock on the object
@export var is_locked_in_place: bool = false
var is_held_by_player_mouse: bool = false
var is_held_by_player_character: bool = false

func _ready():
	lock_icon_sprite.visible = is_locked_in_place
	point_light_2d.color = self.modulate
	# Subscribe signals
	body_entered.connect(_on_body_entered_scale_zone)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	input_event.connect(_on_input_event)


func _process(delta: float):
	if is_held_by_player_mouse:
		position = get_global_mouse_position()

func _on_body_entered_scale_zone(body: Node2D):
	if body is ScalableObject:
		scale_object(body)

func _on_mouse_entered():
	start_selectable_effects()

func _on_mouse_exited():
	stop_selectable_effects()
	
func start_selectable_effects():
	point_light_2d.visible = true
	
func stop_selectable_effects():
	point_light_2d.visible = false
	
func player_character_pickup():
	# What do we want to do here?
	# 1. Disable it's scale effect entirely
	# 2. Attach the object to the player
	# 3. Still retain some of it's collision properties
	pass

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int):
	if event is InputEventMouseButton and event.is_pressed():
		if is_locked_in_place:
			error_sound.play()
			return
		# Toggle is_held_player
		#TODO: current solution is oging to allow players to grab multiple areas at a time
		click_sound.pitch_scale = randf_range(0.8, 1.2)
		click_sound.play()
		is_held_by_player_mouse = !is_held_by_player_mouse

func scale_object(body: ScalableObject):
	body.scale_by_factor(scale_factor)
