extends Node3D
class_name RoadUserVars

@export_category("Movement")
@export var max_speed: float
@export var accel: float
@export var deccel: float

@export_category("Cognition")
@export var visibility: float
@export var reaction_time: float

@export_category("Position guide")
@export var path_follow: PathFollow3D

@export_category("Logic references")
@export var follow_path: FollowPath 
@export var visioncone: VisionCone

func _ready(): 
	# Set al the vars of child states equal to the values of thiss class
	follow_path.max_speed = max_speed
	follow_path.accel = accel
	follow_path.deccel = deccel
	follow_path.path_follow = path_follow
	follow_path.reaction_time = reaction_time
	
	visioncone.ray_length = visibility
	
	print(path_follow)
	print("HALLO")
