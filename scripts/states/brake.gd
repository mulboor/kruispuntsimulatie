extends PathFollowState
class_name Brake

@export var in_area: bool

@export var last_speed: float
@export var last_progress: float

var stopping_distance: float

var brake_distance: float

func enter() -> void: 
	init_state()

func physics_update(_delta): 
	# Minder de snelheid 
	deccelerate()

func on_vis_ray_no_hits() -> void: 
	Transitioned.emit(self, "accelerate")

func deccelerate() -> void: 
	var new_speed: float = lerpf(user_vars.current_speed, user_vars.current_speed - user_vars.deccel, 0.2)
	user_vars.current_speed = maxf(new_speed, 0)
	
	if is_instance_valid(user_vars.path_follow):
		user_vars.path_follow.progress += user_vars.current_speed
		set_position_to(user_vars.path_follow.global_position, user_vars.path_follow.global_rotation)

func check_area() -> void: 
	if traffic_signal_detection_area.get_overlapping_areas().size() > 0: 
		in_area = true
