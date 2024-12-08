extends Node3D
class_name RoadUserVars

@export_category("Movement")
@export var max_speed: float
@export var accel: float
@export var deccel: float
@export var current_speed: float

@export_category("Cognition")
@export var visibility: float
@export var reaction_time: float
@export var stopping_distance: float

@export_category("Position guide")
@export var path_follow: SelfDeletingPathFollow3D
