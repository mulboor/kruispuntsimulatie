extends PathFollowState
class_name Accelerate

@export var danger_cone: VisionCone
@export var danger_cone_ray_distance: float

@onready var current_reaction_time: float

@onready var obstacle_is_visible: bool

@onready var should_brake: bool


func enter() -> void:
	init_state()
	current_reaction_time = user_vars.reaction_time
	user_vars.current_speed = user_vars.max_speed
	obstacle_is_visible = false
	
	danger_cone.ray_hit_obstacle.connect(on_danger_ray_hit)
	danger_cone.no_ray_hits.connect(on_danger_ray_no_hit)
	danger_cone.max_view_distance = danger_cone_ray_distance

func physics_update(_delta: float) -> void:
	# Laat snelheid toenemen tot de max_speed
	accelerate_user()
	
	# Rem wanneer een obstakel te dichtbij is
	check_for_obstacles(_delta)
	
	# Verwijder deze weggebruiker als het pad voltooid is 
	if user_vars.path_follow.progress_ratio >= 1: 
		user_vars.queue_free()

#region Visioncone signals
func on_vis_ray_hit() -> void: 
	obstacle_is_visible = true

func on_vis_ray_no_hits() -> void:
	obstacle_is_visible = false

func on_danger_ray_hit() -> void: 
	if obstacle_is_visible: 
		should_brake = true

func on_danger_ray_no_hit() -> void: 
	should_brake = false
#endregion 

func accelerate_user() -> void: 
	if user_vars.current_speed < user_vars.max_speed:
		user_vars.current_speed = lerpf(user_vars.current_speed, user_vars.current_speed + user_vars.accel, 0.2)
	else:
		user_vars.current_speed = user_vars.max_speed
	
	user_vars.path_follow.progress += user_vars.current_speed
	set_position_to(user_vars.path_follow.global_position, user_vars.path_follow.global_rotation)

func check_for_obstacles(_delta: float) -> void:
	if obstacle_is_visible: 
		current_reaction_time -= _delta
	else: 
		current_reaction_time = user_vars.reaction_time
	
	if current_reaction_time <= 0 && should_brake: 
		Transitioned.emit(self, "brake")
		print("brake")

# Rem als de gebruiker bij een verkeersteken staat. Zonder reactievermogen want verkeerstekens zoals stoplichten kan een mens (meestal) goed anticiperen.
func on_area_entered(area: Area3D) -> void:
	print("STOP")
	if area is TrafficSignal:
		var traffic_signal: TrafficSignal = area
		if traffic_signal.stop_for_signal:  
			Transitioned.emit(self, "brake")
