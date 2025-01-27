extends Node
class_name Factoren

@export_category("Factors")
@export var avg_car_speed: float 
@export var avg_visibility: float
@export var avg_reaction_time: float

@export_category("Stats")
@export var car_stats: GeneralRoadUserStats
@export var non_car_stats: Array[GeneralRoadUserStats]

func _ready():
	for stat in non_car_stats: 
		stat.visibility = avg_visibility
		stat.reaction_time = avg_reaction_time
	
	car_stats.reaction_time = avg_reaction_time
	car_stats.visibility = avg_visibility
	car_stats.max_speed = avg_car_speed
