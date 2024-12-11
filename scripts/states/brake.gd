extends PathFollowState
class_name Brake

@export var static_vision_cone: VisionCone

@onready var stop_here: bool
@onready var should_accel: bool
@onready var no_static_ray_hits: bool
@onready var no_ray_hits: bool

func enter() -> void:
	static_vision_cone.max_view_distance = user_vars.visibility
	static_vision_cone.generate_raycasts()
	static_vision_cone.no_ray_hits.connect(on_static_vis_ray_no_hits)
	static_vision_cone.ray_hit_obstacle.connect(on_static_vis_ray_hit)

func physics_update(_delta): 
	# Minder de snelheid 
	deccelerate()
	
	if in_area() && user_vars.current_speed == 0 && !in_perm_stop():
		if no_static_ray_hits: 
			Transitioned.emit(self, "accelerate")
	
	if !in_area() && no_ray_hits:
		Transitioned.emit(self, "accelerate")

func on_static_vis_ray_no_hits() -> void:
	no_static_ray_hits = true

func on_static_vis_ray_hit() -> void: 
	no_static_ray_hits = false

func on_vis_ray_hit() -> void: 
	no_ray_hits = false

func on_vis_ray_no_hits() -> void: 
	no_ray_hits = true

func deccelerate() -> void: 
	var new_speed: float = lerpf(user_vars.current_speed, user_vars.current_speed - user_vars.deccel, 0.2)
	user_vars.current_speed = maxf(new_speed, 0)
	
	if is_instance_valid(user_vars.path_follow):
		user_vars.path_follow.progress += user_vars.current_speed
		set_position_to(user_vars.path_follow.global_position, user_vars.path_follow.global_rotation)

func in_area() -> bool: 
	var areas: Array[Area3D] = traffic_signal_detection_area.get_overlapping_areas()
	if traffic_signal_detection_area.get_overlapping_areas().size() == 0: 
		return false
	return true

func in_perm_stop() -> bool: 
	var areas: Array[Area3D] = traffic_signal_detection_area.get_overlapping_areas()
	for area in areas: 
		if area is TrafficSignal: 
			var traf_signal: TrafficSignal = area
			if area.stop_at_signal:
				return true
				break
			else:
				return false
	return false
