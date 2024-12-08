extends Node3D
class_name RoadUserSpawner

@export_category("Spawn variables")
@export var time_between_spawns: float

@export_category("User variables")
@export var general_user_stats: GeneralRoadUserStats

@export_category("Spawner path")
@export var path: Path3D
@export var path_follow: PackedScene

@export_category("User scene")
@export var user: PackedScene

@onready var current_time_between_spawns: float

@onready var time: float
@onready var frame: int

func _ready() -> void:
	current_time_between_spawns = 0 
	frame = 0

func _physics_process(delta):
	spawn_users(delta)
	time += delta
	frame += 1
	#print("Time:", time, " Frame:", frame)

func spawn_users(_delta: float): 
	# Spawn elke x seconden een nieuwe weggebruiker
	if current_time_between_spawns <= 0: 
		spawn_user()
		current_time_between_spawns = time_between_spawns
	elif current_time_between_spawns > 0: 
		current_time_between_spawns -= _delta

func spawn_user() -> void:
	# Maak een nieuwe path_follow die de weggebruiker gaat volgen
	var current_path_follow = path_follow.instantiate()
	path.add_child(current_path_follow)
	
	# Maak de weggebruiker
	var inst_user: RoadUserVars = user.instantiate()
	inst_user.max_speed = maxf(randfn(general_user_stats.max_speed, general_user_stats.max_speed_deviation), 0.0)
	inst_user.accel = maxf(randfn(general_user_stats.accel, general_user_stats.accel_deviation), 0.0)
	inst_user.deccel = maxf(randfn(general_user_stats.deccel, general_user_stats.deccel_deviation), 0.0)
	inst_user.visibility = maxf(randfn(general_user_stats.visibility, general_user_stats.visibility_deviation), 0.0)
	inst_user.reaction_time = maxf(randfn(general_user_stats.reaction_time, general_user_stats.reaction_time_deviation), 0.0)
	inst_user.stopping_distance = maxf(randfn(general_user_stats.stopping_distance, general_user_stats.stopping_distance_deviation), 0.0)
	inst_user.path_follow = current_path_follow
	add_child(inst_user)
