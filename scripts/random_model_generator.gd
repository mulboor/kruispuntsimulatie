extends Node3D

func _ready():
	var disabled_model: Node3D = get_children().pick_random()
	disabled_model.hide()
