extends Node
class_name RoadUserStats

@export_category("Movement")
@export var max_speed: float
@export var accel: float
@export var deccel: float
@export_category("Cognition")
@export var visibility: float 
@export var reaction_time: float

signal SendVars(max_speed: float, accel: float, deccel: float, visibility: float, reaction_time: float)

func _ready() -> void:
	SendVars.emit(max_speed, accel, deccel, visibility, reaction_time) 
