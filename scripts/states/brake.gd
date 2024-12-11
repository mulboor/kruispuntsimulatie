extends PathFollowState
class_name Brake

@export var static_vision_cone: VisionCone

@onready var stop_here: bool
@onready var wait_here: bool

func enter() -> void: 
	init_state()
	visioncone.max_view_distance = user_vars.visibility

func physics_update(_delta): 
	# Minder de snelheid 
	deccelerate()
	
	check_area()

func on_vis_ray_no_hits() -> void: 
	if !stop_here && wait_here:
		Transitioned.emit(self, "accelerate")

func deccelerate() -> void: 
	var new_speed: float = lerpf(user_vars.current_speed, user_vars.current_speed - user_vars.deccel, 0.2)
	user_vars.current_speed = maxf(new_speed, 0)
	
	if is_instance_valid(user_vars.path_follow):
		user_vars.path_follow.progress += user_vars.current_speed
		set_position_to(user_vars.path_follow.global_position, user_vars.path_follow.global_rotation)

func check_area() -> void: 
	var areas: Array[Area3D] = traffic_signal_detection_area.get_overlapping_areas()
	if traffic_signal_detection_area.get_overlapping_areas().size() == 0: 
		stop_here = false
	
	for area in areas: 
		if area is TrafficSignal: 
			var traffic_signal: TrafficSignal = area
			if traffic_signal.stop_at_signal: 
				stop_here = true
				break
			elif traffic_signal.wait_at_signal: 
				wait_here = true
				break
