extends PathFollowState
class_name Brake

func enter() -> void: 
	init_path_follow_state()
	visioncone.no_hits.connect(on_no_hits)

func physics_update(_delta): 
	# Minder de snelheid 
	user_vars.current_speed = lerpf(user_vars.current_speed, 0.0, user_vars.deccel / user_vars.current_speed * user_vars.current_speed)
	user_vars.path_follow.progress += user_vars.current_speed
	set_position_to(user_vars.path_follow)

func on_no_hits() -> void: 
	Transitioned.emit(self, "accelerate")
