extends PathFollowState
class_name Accelerate

func enter() -> void:
	init_path_follow_state()

func physics_update(_delta: float) -> void:
	# Laat snelheid toenemen tot de max_speed
	if current_speed < user_vars.max_speed:
		current_speed += user_vars.accel
	else:
		current_speed = user_vars.max_speed
	
	user_vars.path_follow.progress += current_speed
	
	# Zet de positie van de auto gelijk aan die van de path_follow. 
	# Niet op de y want dan zou het de grond in gaan. 
	user_vars.global_position.z = user_vars.path_follow.global_position.z
	user_vars.global_position.x = user_vars.path_follow.global_position.x
	user_vars.global_rotation = user_vars.path_follow.global_rotation
	
	# Verwijder de auto als het pad voltooid is
	if user_vars.path_follow.progress_ratio >= 1:
		user_vars.queue_free()

func on_body_entered(body: Node) -> void: 
	if body.name != "Ground": 
		Transitioned.emit(self, "Crash")

func on_non_ground_hit(bode: Node) -> void:
	Transitioned.emit(self, "brake")
	print("braking")
