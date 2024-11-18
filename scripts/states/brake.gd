extends PathFollowState
class_name Brake

func enter() -> void: 
	init_active_state()

func physics_update(_delta): 
	# Minder de snelheid 
	var new_current_speed: float
	if user_vars.current_speed < 1: 
		new_current_speed = maxf(0, user_vars.current_speed - (user_vars.deccel * (user_vars.current_speed * user_vars.current_speed)))
	elif user_vars.current_speed >= 1:
		new_current_speed = maxf(0, user_vars.current_speed - (user_vars.deccel / (user_vars.current_speed * user_vars.current_speed)))
	user_vars.current_speed = new_current_speed
	user_vars.path_follow.progress += user_vars.current_speed
	set_position_to(user_vars.path_follow)

func on_no_hits() -> void: 
	Transitioned.emit(self, "accelerate")
