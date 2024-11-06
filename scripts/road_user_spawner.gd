extends Node

@export var user_per_minute: int

@onready var path: Path3D

@onready var user: MoverState

func _ready() -> void:
	print(calc_spawnrate())

func spawn_user(user: Node) -> void:
	# Maak een nieuwe path_follow die de gebruiker gaat volgen
	var path_follow: PathFollow3D = PathFollow3D.new()
	path_follow.position = Vector3(0.0, 0.0, 0.0)
	path.add_child(path_follow)
	
	# Maak de gebruiker
	add_child(user)
	user.path_follow = path_follow

func spawn_users(spawnrate: int) -> void: 
	for n in (spawnrate + 1):
		spawn_user(user)

# Bereken het aantal gebruikers die per frame moeten spawnen
func calc_spawnrate() -> int: 
	var upm_float: float = float(user_per_minute)
	var fpm: float = Engine.get_frames_per_second() * 60
	var spawnrate_float: float = upm_float / fpm
	return int(spawnrate_float)
