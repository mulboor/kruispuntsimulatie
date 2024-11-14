extends Node
class_name GeneralRoadUserStats

@export_category("Movement")
@export var max_speed: float
@export var accel: float
@export_range(0, 1) var deccel: float
@export_category("Cognition")
@export var visibility: float 
@export var reaction_time: float
