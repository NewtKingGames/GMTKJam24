class_name ScaleZone extends Area2D

@onready var point_light_2d = $PointLight2D

var scale_factor: float
var is_held_by_player: bool = false

func _ready():
	point_light_2d.color = self.modulate
	# Subscribe signals
	body_entered.connect(_on_body_entered_scale_zone)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	input_event.connect(_on_input_event)


func _process(delta: float):
	if is_held_by_player:
		position = get_global_mouse_position()

func _on_body_entered_scale_zone(body: Node2D):
	if body is ScalableObject:
		scale_object(body)

func _on_mouse_entered():
	point_light_2d.visible = true

func _on_mouse_exited():
	point_light_2d.visible = false

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int):
	if event is InputEventMouseButton and event.is_pressed():
		# Toggle is_held_player
		#TODO: current solution is oging to allow players to grab multiple areas at a time
		is_held_by_player = !is_held_by_player

func scale_object(body: ScalableObject):
	body.scale_by_factor(scale_factor)
