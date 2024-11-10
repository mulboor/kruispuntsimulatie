extends Node3D
class_name RoadUserVars

@export_category("Movement")
@export var max_speed: float
@export var accel: float
@export var deccel: float

@export_category("Position guide")
@export var path_follow: PathFollow3D
