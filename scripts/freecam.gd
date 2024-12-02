extends Node3D

@export var accel: float

func _process(delta) -> void:
	position += get_velocity(accel, delta)

func get_velocity(accel: float, _delta: float) -> Vector3: 
	var y: float = get_axis("move_up", "move_down") * accel * _delta
	var z: float = get_axis("move_forward", "move_backwards") * accel * _delta
	var x: float = get_axis("move_right", "move_left") * accel * _delta
	var vel: Vector3 = Vector3(x, y, -z)
	return vel.normalized()

func get_axis(input_pos: String, input_neg: String) -> float: 
	var axis: float
	if Input.is_action_pressed(input_pos): 
		axis = 1 
	elif Input.is_action_pressed(input_neg):
		axis = -1
	elif Input.is_action_pressed(input_neg) && Input.is_action_pressed(input_pos): 
		axis = 0
	else: 
		axis = 0
	return axis
