extends PathFollowState
class_name Accelerate

@onready var current_reaction_time: float
@onready var distance_to_obstacle: float
@onready var stopping_distance: float

@onready var obstacle_spotted: float

@onready var brake: bool

func enter() -> void:
	init_state()
	current_reaction_time = user_vars.reaction_time

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
	
	print("Brake distance: ", calc_brake_distance(user_vars.current_speed, user_vars.deccel))

func on_vis_non_ground_hit(body: Node, distance: float) -> void:
	if distance < calc_brake_distance(user_vars.current_speed, user_vars.deccel) * 5:
		brake = true
		print("Brake true")

func count_down_to_brake(_delta: float) -> void: 
	current_reaction_time -= _delta
	
	if current_reaction_time <= 0: 
		Transitioned.emit(self, "brake")

func calc_brake_distance(velocity: float, brake_force: float) -> float: 
	var delta_ticks: int = roundi(velocity / brake_force)
	var brake_distance: float
	for i in range(delta_ticks): 
		velocity -= brake_force
		brake_distance += velocity
	return maxf(brake_distance, 0)
