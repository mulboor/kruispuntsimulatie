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

@onready var ped_total_upm: float
@onready var car_total_upm: float
@onready var bike_total_upm: float


func _ready() -> void:
	# Check of de percentages wel kloppen
	var total_percentage: float 
	total_percentage = ped_percentage + bike_percentage + car_percentage
	if total_percentage > 100: 
		print("Total percentage of users spawned is greater than 100!")
	
	# Check of alle arrays dezelfde lengte hebben
	if !equal_arrays(): 
		print("Amount of spawners and amount of spawner percentages are not equal!") 
	
	# Bereken en assign de delay van de spawners
	assign_spawners(total_upm, ped_percentage, ped_percentage_per_spawner, ped_spawners)
	assign_spawners(total_upm, bike_percentage, bike_percentage_per_spawner, bike_spawners)
	assign_spawners(total_upm, car_percentage, car_percentage_per_spawner, car_spawners)

func equal_arrays() -> bool: 
	if car_percentage_per_spawner.size() != car_spawners.size() || ped_percentage_per_spawner.size() != ped_spawners.size() || bike_percentage_per_spawner.size() != bike_spawners.size():
		return false
	return true

func get_spawn_delay(user_per_minute: float) -> float: 
	return 60 / user_per_minute

func get_delays(percentages: Array[float], upm: float) -> Array[float]: 
	var delays: Array[float]
	for percentage in percentages: 
		var specif_upm: float
		specif_upm = get_percentage_of(upm, percentage)
		var delay: float
		delay = 60 / specif_upm
		delays.append(delay)
	return delays

func assign_delays(delays: Array[float], spawners: Array[RoadUserSpawner]) -> void:
	for i in range(spawners.size()):
		spawners[i].time_between_spawns = delays[i] 

func get_percentage_of(n: float, percentage: float) -> float: 
	return (n / 100) * percentage

func assign_spawners(upm: float, percentage: float, percentage_per_spawner: Array[float], spawners: Array[RoadUserSpawner]) -> void: 
	var specif_total_upm: float = get_percentage_of(upm, percentage)
	var delays: Array[float] = get_delays(percentage_per_spawner, specif_total_upm) 
	assign_delays(delays, spawners)
