extends Node

signal all_scale_goals_hit()

var scales_in_level: Array[Node]
var scales_with_goal_met: int = 0

func _ready():
	scales_in_level = get_tree().get_nodes_in_group("scales")
	for scale in scales_in_level:
		scale.connect("scale_goal_hit", _on_scale_goal_hit)
		scale.connect("scale_goal_lost", _on_scale_goal_lost)




func _on_scale_goal_hit():
	scales_with_goal_met += 1
	if scales_with_goal_met == scales_in_level.size():
		all_scale_goals_hit.emit()

func _on_scale_goal_lost():
	print("scale goal lost")
	scales_with_goal_met -= 1
