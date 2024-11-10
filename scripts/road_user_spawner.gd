extends Node
class_name RoadUserSpawner

@export_category("Spawn variables")
@export var time_between_spawns: float

@export_category("User variables")
@export var general_user_stats: GeneralRoadUserStats

@export_category("Spawner path")
@export var path: Path3D

@export_category("User scene")
@export var user: PackedScene

@onready var current_time_between_spawns: float

func _ready() -> void:
	current_time_between_spawns = 0 

func _physics_process(delta):
	spawn_users(delta)

func spawn_user() -> void:
	# Maak een nieuwe path_follow die de gebruiker gaat volgen
	var path_follow: PathFollow3D = PathFollow3D.new()
	path_follow.position = Vector3(0.0, 0.0, 0.0)
	path.add_child(path_follow)
	
	# Maak de gebruiker
	var inst_user: RoadUserVars = user.instantiate()
	inst_user.max_speed = general_user_stats.max_speed
	inst_user.accel = general_user_stats.accel
	inst_user.path_follow = path_follow
	add_child(inst_user)

func spawn_users(_delta: float): 
	if current_time_between_spawns <= 0: 
		print("jerking off")
		spawn_user()
		current_time_between_spawns = time_between_spawns
	elif current_time_between_spawns > 0: 
		current_time_between_spawns -= _delta
