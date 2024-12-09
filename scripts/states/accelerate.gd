extends PathFollowState
class_name Accelerate

@onready var current_reaction_time: float
@onready var distance_to_obstacle: float
@onready var stopping_distance: float

@onready var obstacle_spotted: float

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
	
	# Rem wanneer een obstakel te dichtbij is
	if obstacle_spotted: 
		count_down_to_brake(_delta) 
	
	# Verwijder deze weggebruiker als het pad voltooid is 
	if user_vars.path_follow.progress_ratio >= 1: 
		user_vars.queue_free()

func on_vis_ray_hit(object_hit: Node, distance: float) -> void: 
	if distance < user_vars.visibility: 
		obstacle_spotted = true
	else: 
		obstacle_spotted = false
	print("Obstacle spotted: ", obstacle_spotted)

func count_down_to_brake(_delta: float) -> void: 
	current_reaction_time -= _delta
	
	if current_reaction_time <= 0: 
		Transitioned.emit(self, "brake")
