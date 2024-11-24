extends PathFollowState
class_name Accelerate

@onready var current_reaction_time: float
@onready var distance_to_obstacle: float
@onready var stopping_distance

@onready var brake: bool

func enter() -> void:
	init_state()
	current_reaction_time = user_vars.reaction_time
	brake = false

func physics_update(_delta: float) -> void:
	# Laat snelheid toenemen tot de max_speed
	if user_vars.current_speed < user_vars.max_speed:
		user_vars.current_speed = lerpf(user_vars.current_speed, user_vars.current_speed + user_vars.accel, 0.2)
	else:
		user_vars.current_speed = user_vars.max_speed
	
	if is_instance_valid(user_vars):
		user_vars.path_follow.progress += user_vars.current_speed
	
	set_position_to(user_vars.path_follow)
	
	# Verwijder de auto als het pad voltooid is
	if user_vars.path_follow.progress_ratio >= 1:
		user_vars.queue_free()
	
	# Verander naar de rem state wanneer er een object in het pad zit
	if brake: 
		count_down_to_brake(_delta)

func on_non_ground_hit(body: Node, distance: float) -> void:
	brake = true
	distance_to_obstacle = distance

func count_down_to_brake(_delta: float) -> void: 
	current_reaction_time -= _delta
	
	stopping_distance = minf((user_vars.visibility / 100) * user_vars.stopping_distance * user_vars.current_speed, user_vars.visibility)
	if current_reaction_time <= 0 && distance_to_obstacle < stopping_distance: 
		Transitioned.emit(self, "brake")
