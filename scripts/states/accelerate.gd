extends PathFollowState
class_name Accelerate

func enter() -> void:
	init_path_follow_state()

func physics_update(_delta: float) -> void:
	# Laat snelheid toenemen tot de max_speed
	if user_vars.current_speed < user_vars.max_speed:
		user_vars.current_speed += user_vars.accel
	else:
		user_vars.current_speed = user_vars.max_speed
	
	user_vars.path_follow.progress += user_vars.current_speed
	
	set_position_to(user_vars.path_follow)
	
	# Verwijder de auto als het pad voltooid is
	if user_vars.path_follow.progress_ratio >= 1:
		user_vars.queue_free()

func on_non_ground_hit(body: Node) -> void:
	Transitioned.emit(self, "brake")
