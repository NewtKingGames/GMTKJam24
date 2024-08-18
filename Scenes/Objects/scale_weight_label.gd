extends Label

func _ready():
	text = str(0)

# Make text Red if not enough make text green if correct
# TODO - play some kind of animation?
func _on_basic_scale_platform_scale_weight_changed(weight):
	text = str(weight)
