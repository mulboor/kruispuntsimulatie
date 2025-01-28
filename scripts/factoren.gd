extends Node
class_name Factoren

@onready var avg_car_speed: float 
@onready var avg_visibility: float
@onready var avg_reaction_time: float

@export_category("Stats")
@export var car_stats: GeneralRoadUserStats
@export var non_car_stats: Array[GeneralRoadUserStats]

func _ready():
	avg_car_speed = Singleton.avg_speed_singleton
	avg_visibility = Singleton.avg_vis_singleton
	avg_reaction_time = Singleton.avg_react_singleton
	
	for stat in non_car_stats: 
		stat.visibility = avg_visibility
		stat.reaction_time = avg_reaction_time
	
	car_stats.reaction_time = avg_reaction_time
	car_stats.visibility = avg_visibility
	car_stats.max_speed = avg_car_speed
