extends Node

@export var car_spawners: Array[RoadUserSpawner]
@export var bike_spawners: Array[RoadUserSpawner]
@export var ped_spawners: Array[RoadUserSpawner]

@export var total_upm: float # UPM = roadusers per minute

@export_category("Peds")
@export_range(0, 100) var ped_percentage: float
@export_range(0, 100) var ped_percentage_per_spawner: Array[float]

@export_category("Cars")
@export_range(0, 100) var car_percentage: float
@export_range(0, 100) var car_percentage_per_spawner: Array[float]

@export_category("Bikes") 
@export_range(0, 100) var bike_percentage: float
@export_range(0, 100) var bike_percentage_per_spawner: Array[float]

@onready var ped_upm: float
@onready var car_upm: float
@onready var bike_upm: float


func _ready() -> void:
	# Check of de percentages wel kloppen
	var total_percentage: float 
	total_percentage = ped_percentage + bike_percentage + car_percentage
	if total_percentage > 100: 
		print("Total percentage of users spawned is greater than 100!")
	
	# Check of alle arrays dezelfde lengte hebben
	if !equal_arrays(): 
		print("Amount of spawners and amount of spawner percentages are not ") 
	
	

func equal_arrays() -> bool: 
	if car_percentage_per_spawner.size() != car_spawners.size() || ped_percentage_per_spawner.size() != ped_spawners.size() || bike_percentage_per_spawner.size() != bike_spawners.size():
		return false
	return true

func get_spawn_delay(user_per_minute: float) -> float: 
	return 60 / user_per_minute

func assign_delays(spawners: Array[RoadUserSpawner], delay: float) -> void: 
	for spawner in spawners:
		spawner.time_between_spawns = delay

func get_percentage(n: float, percentage: float) -> float: 
	return (n / 100) * percentage
