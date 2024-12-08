extends PathFollowState
class_name Brake

@export var in_area: bool

@export var last_speed: float
@export var last_progress: float

var stopping_distance: float

var brake_distance: float

func enter() -> void: 
	init_state()
	
	last_speed = user_vars.current_speed
	print("last speed: ", last_speed)
	last_progress = user_vars.path_follow.progress
	stopping_distance = 0
	print("deccel: ", user_vars.deccel)

func physics_update(_delta): 
	# Minder de snelheid 
	if user_vars.current_speed - user_vars.deccel <= 0:
		user_vars.current_speed = 0
		print("brake distance: ", brake_distance)
	else:
		user_vars.current_speed = lerpf(user_vars.current_speed, user_vars.current_speed - user_vars.deccel, 0.2)
		brake_distance += lerpf(user_vars.current_speed, user_vars.current_speed - user_vars.deccel, 0.2)
		print("current_speed: ", user_vars.current_speed)
	
	if is_instance_valid(user_vars.path_follow):
		user_vars.path_follow.progress += user_vars.current_speed
		set_position_to(user_vars.path_follow.global_position, user_vars.path_follow.global_rotation)
		print("dikke lul")
	
	# Verander naar sweep als self in een verkeersignaal staat en stilstaat
	if start_sweep(): 
		Transitioned.emit(self, "sweep")

func on_vis_ray_hit(object_hit: Node, distance: float) -> void: 
	pass

func on_area_hit(area: Node, distance: float) -> void: 
	in_area = true

func start_sweep() -> bool: 
	if in_area && user_vars.current_speed <= 0: 
		return true
	return false
