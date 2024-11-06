extends Node
class_name RoadUserSpawner

@onready var path: Path3D

@onready var user: MoverState

@onready var time_between_spawns: float 
@onready var current_time_between_spawns: float

func _ready() -> void:
	current_time_between_spawns = 0 

func _physics_process(delta: float) -> void:
	if current_time_between_spawns <= 0: 
		spawn_user(user)
		current_time_between_spawns = time_between_spawns
	elif current_time_between_spawns > 0: 
		current_time_between_spawns -= delta

func spawn_user(user: Node) -> void:
	# Maak een nieuwe path_follow die de gebruiker gaat volgen
	var path_follow: PathFollow3D = PathFollow3D.new()
	path_follow.position = Vector3(0.0, 0.0, 0.0)
	path.add_child(path_follow)
	
	# Maak de gebruiker
	add_child(user)
	user.path_follow = path_follow
