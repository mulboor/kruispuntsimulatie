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
	obstacle_spotted = false

func physics_update(_delta: float) -> void:
	# Laat snelheid toenemen tot de max_speed
	if user_vars.current_speed < user_vars.max_speed:
		user_vars.current_speed = lerpf(user_vars.current_speed, user_vars.current_speed + user_vars.accel, 0.2)
	else:
		user_vars.current_speed = user_vars.max_speed
	
	user_vars.path_follow.progress += user_vars.current_speed
	set_position_to(user_vars.path_follow.global_position, user_vars.path_follow.global_rotation)
	
	# Laat de reactietijd aflopen bij een gevaarlijke situatie 
	if obstacle_spotted: 
		current_reaction_time -= _delta
		print("Cur reaction time: ", current_reaction_time)
	else: 
		current_reaction_time = user_vars.reaction_time
	
	# Rem af als de reactietijd is verlopen na een gevaarlijke situatie
	if current_reaction_time <= 0 && obstacle_spotted: 
		Transitioned.emit(self, "brake")
		print("braking")
	
	# Verwijder deze weggebruiker als het pad voltooid is 
	if user_vars.path_follow.progress_ratio >= 1: 
		user_vars.queue_free()
	
	print("Brake distance: ", calc_brake_distance_squared(user_vars.current_speed, user_vars.deccel))

func on_vis_ray_hit(object_hit: Node, distance: float) -> void: 
	#print("Sqrt distance: ", distance * distance)
	#if distance <= user_vars.visibility: 
		#obstacle_spotted = true
		#distance_to_obstacle = distance
		#print("vis ray hit")
	obstacle_spotted = true
	print("Gezien")

func on_no_vis_hits() -> void: 
	#obstacle_spotted = false
	pass

func in_danger_distance() -> bool: 
	if (distance_to_obstacle * distance_to_obstacle) <= calc_brake_distance_squared(user_vars.current_speed, user_vars.deccel) * user_vars.stopping_distance_multiplier: 
		return true
	return false

func calc_brake_distance_squared(velocity: float, brake_force: float) -> float: 
	var delta_ticks: float = velocity / brake_force
	var brake_distance: float
	for i in range(delta_ticks): 
		velocity -= brake_force
		brake_distance += velocity
	return maxf(brake_distance * brake_distance, 0)
