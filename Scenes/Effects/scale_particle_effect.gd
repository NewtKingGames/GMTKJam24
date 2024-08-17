class_name ScaleParticleEffect extends Node2D

@onready var scale_particle_effect: CPUParticles2D = $ScaleParticleEffect

func _ready():
	scale_particle_effect.emitting = false

func start_particle_effects():
	scale_particle_effect.emitting = true

func stop_particle_effects():
	scale_particle_effect.emitting = false

# We actually need to change the radius and other effects of the thing itself
func change_scale_of_particle_effect(scale_factor: float):
	# Have these be done with tweens
	var tween: Tween = create_tween()
	print("scale factor is")
	print(scale_factor)
	tween.parallel().tween_property(scale_particle_effect, "emission_sphere_radius", scale_particle_effect.emission_sphere_radius * scale_factor, Globals.scale_duration)
	tween.parallel().tween_property(scale_particle_effect, "scale_amount_min", scale_particle_effect.scale_amount_min * scale_factor, Globals.scale_duration)
	tween.parallel().tween_property(scale_particle_effect, "scale_amount_max", scale_particle_effect.scale_amount_max * scale_factor, Globals.scale_duration)
