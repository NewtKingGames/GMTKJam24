extends Label

var label_prefix: String = "Current Weight: "

func _ready():
	text = label_prefix + str(0)

func _on_basic_scale_platform_scale_weight_changed(weight):
	text = label_prefix + str(weight)
