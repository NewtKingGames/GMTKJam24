class_name ScaleZone extends Area2D

@onready var point_light_2d = $PointLight2D
@onready var lock_icon_sprite = $LockIconSprite
@onready var arrow_icon_sprite = $ArrowIconSprite

@onready var error_sound = $ErrorSound
@onready var click_sound = $ClickSound

var scale_factor: float
# Set this to true to prevent the player from moving it and render a small lock on the object
@export var is_locked_in_place: bool = false
var is_held_by_player_mouse: bool = false
var is_held_by_player_character: bool = false

# Don't scale objects until the level starts and sets this to true
var can_zone_scale_objects: bool = false
# Prevent zone from being moved after the level is started
var can_zone_be_grabbed_by_mouse:bool = true

func _ready():
	lock_icon_sprite.visible = is_locked_in_place
	arrow_icon_sprite.visible = !is_locked_in_place
	point_light_2d.color = self.modulate
	# Subscribe signals
	body_entered.connect(_on_body_entered_scale_zone)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	input_event.connect(_on_input_event)


func _process(delta: float):
	if is_held_by_player_mouse:
		position = get_global_mouse_position()

func level_started():
	can_zone_scale_objects = true
	can_zone_be_grabbed_by_mouse = false

func _on_body_entered_scale_zone(body: Node2D):
	if body is ScalableObject:
		scale_object(body)
	if body is Player:
		scale_player(body)

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
	if event is InputEventMouseButton and event.is_pressed() and can_zone_be_grabbed_by_mouse:
		if is_locked_in_place:
			error_sound.play()
			return
		if is_held_by_player_mouse:
			released_by_mouse()
		else: 
			grabbed_by_mouse()
		
		
#TODO: current solution is oging to allow players to grab multiple areas at a time
func grabbed_by_mouse():
	click_sound.pitch_scale = randf_range(0.8, 1.2)
	click_sound.play()
	is_held_by_player_mouse = true
	grabbed_effect()


func released_by_mouse():
	click_sound.pitch_scale = randf_range(0.8, 1.2)
	click_sound.play()
	is_held_by_player_mouse = false
	released_effect()
	
func grabbed_effect():
	var tween_size: Tween = create_tween().parallel()
	var tween_rotate: Tween = create_tween()
	# Bounce object larger
	tween_size.tween_property(self, "scale", Vector2(1.2, 1.2), 1).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	var max_rotation = randi_range(20, 30)
	var rotate_direction = randi_range(0, 1)
	if rotate_direction == 0:
		rotate_direction = -1
	tween_rotate.tween_property(self, "rotation_degrees", max_rotation * rotate_direction, 0.05)
	tween_rotate.tween_property(self, "rotation_degrees", 0, 0.05)
	tween_rotate.tween_property(self, "rotation_degrees", max_rotation * randf_range(0.3, 0.6) * rotate_direction * -1, 0.05)
	tween_rotate.tween_property(self, "rotation_degrees", 0, 0.05)
	tween_rotate.tween_property(self, "rotation_degrees", max_rotation * randf_range(0.1, 0.3) * rotate_direction, 0.05)
	tween_rotate.tween_property(self, "rotation_degrees", 0, 0.05)
	#tween.tween_property()

func released_effect():
	var tween: Tween = create_tween()
	# Bounce object smaller
	tween.tween_property(self, "scale", Vector2(1,1), 1).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	var tween_rotate: Tween = create_tween()
	var max_rotation = randi_range(20, 30)
	var rotate_direction = randi_range(0, 1)
	if rotate_direction == 0:
		rotate_direction = -1
	tween_rotate.tween_property(self, "rotation_degrees", max_rotation * rotate_direction, 0.05)
	tween_rotate.tween_property(self, "rotation_degrees", 0, 0.05)
	tween_rotate.tween_property(self, "rotation_degrees", max_rotation * randf_range(0.3, 0.6) * rotate_direction * -1, 0.05)
	tween_rotate.tween_property(self, "rotation_degrees", 0, 0.05)
	tween_rotate.tween_property(self, "rotation_degrees", max_rotation * randf_range(0.1, 0.3) * rotate_direction, 0.05)
	tween_rotate.tween_property(self, "rotation_degrees", 0, 0.05)

func scale_object(body: ScalableObject):
	if can_zone_scale_objects:
		body.scale_by_factor(scale_factor)

func scale_player(player: Player):
	player.scale_by_factor(scale_factor)
