extends PathFollowState
class_name Accelerate

@onready var current_reaction_time: float

@onready var brake: bool

func enter() -> void:
	init_path_follow_state()
	current_reaction_time = user_vars.reaction_time
	brake = false

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
	
	# Verander naar de rem state wanneer er een object in het pad zit
	if brake: 
		count_down_to_brake(_delta)

func on_non_ground_hit(body: Node, distance: float) -> void:
	if distance <= user_vars.stopping_distance: 
		brake = true
	else: 
		pass

func count_down_to_brake(_delta: float) -> void: 
	current_reaction_time -= _delta
	
	if current_reaction_time <= 0: 
		Transitioned.emit(self, "brake")
