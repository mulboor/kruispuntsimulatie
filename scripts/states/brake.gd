extends PathFollowState
class_name Brake

@export var in_area: bool

func enter() -> void: 
	init_active_state()

func physics_update(_delta): 
	# Minder de snelheid 
	var new_current_speed: float
	new_current_speed -= (user_vars.current_speed * user_vars.current_speed) / user_vars.deccel
	user_vars.current_speed = absf(new_current_speed)
	user_vars.path_follow.progress += user_vars.current_speed
	set_position_to(user_vars.path_follow)
	
	# Verander naar sweep als self in een verkeersignaal staat en stilstaat
	if start_sweep(): 
		Transitioned.emit(self, "sweep")

func on_no_hits() -> void: 
	Transitioned.emit(self, "accelerate")

func on_area_hit(area: Node) -> void: 
	in_area = true

func start_sweep() -> bool: 
	if in_area && user_vars.current_speed <= 0: 
		return true
	return false
