extends State
class_name FollowPath

@export var rb: RigidBody3D

var path_follow: PathFollow3D

var max_speed: float
var speed: float
var accel: float
var decell: float
var reaction_time: float

var follow_path: bool

func enter() -> void:
	max_speed = rb.max_speed
	accel = rb.accel
	#decell = rb.decell
	#reaction_time = rd.reaction_time
	path_follow = rb.path_follow
	
	rb.freeze = true
	
	follow_path = true

func physics_update(_delta) -> void:
	if follow_path:
		if speed < max_speed:
			speed += accel
		else:
			speed = max_speed
		
		path_follow.progress += speed

	rb.global_position.z = path_follow.position.z
	rb.global_position.x = path_follow.position.x
	rb.rotation = path_follow.rotation
