extends PathFollowState
class_name Accelerate

@onready var current_reaction_time: float

@onready var obstacle_is_visible: bool
@onready var obstacle_is_close: bool

func enter() -> void:
	init_state()
	current_reaction_time = user_vars.reaction_time
	
	obstacle_is_close = false
	obstacle_is_visible = false

func physics_update(_delta: float) -> void:
	# Laat snelheid toenemen tot de max_speed
	if user_vars.current_speed < user_vars.max_speed:
		user_vars.current_speed = lerpf(user_vars.current_speed, user_vars.current_speed + user_vars.accel, 0.2)
	else:
		user_vars.current_speed = user_vars.max_speed
	
	user_vars.path_follow.progress += user_vars.current_speed
	set_position_to(user_vars.path_follow.global_position, user_vars.path_follow.global_rotation)
	
	# Rem wanneer een obstakel te dichtbij is
	if obstacle_is_visible: 
		current_reaction_time -= _delta
	else: 
		current_reaction_time = user_vars.reaction_time
	
	if obstacle_is_close && current_reaction_time <= 0: 
		Transitioned.emit(self, "brake")
		print("brake")
	
	# Verwijder deze weggebruiker als het pad voltooid is 
	if user_vars.path_follow.progress_ratio >= 1: 
		user_vars.queue_free()

func on_vis_ray_hit() -> void: 
	obstacle_is_visible = true
	obstacle_is_close = true

func on_vis_ray_no_hit() -> void:
	obstacle_is_visible = false
	obstacle_is_close = false
