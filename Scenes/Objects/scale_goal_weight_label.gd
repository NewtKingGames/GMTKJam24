extends Label

var label_prefix: String = "Goal Weight: "

func _ready():
	text = label_prefix + str($"..".goal_weight)
