extends PathFollowState
class_name Brake

func enter() -> void: 
	init_path_follow_state()

func physics_update(_delta): 
	# Minder de snelheid 
	lerpf(current_speed, 0.0, user_vars.deccel)
	user_vars.path_follow.progress += current_speed
	print(current_speed)
