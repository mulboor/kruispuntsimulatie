extends State
class_name MoverState

# Alle states voor de weggebruikers extenden uit deze class. 

@export var max_speed: float
@export var accel: float
@export var decell: float
@export var reaction_time: float

@export var path_follow: PathFollow3D

@export var rigidbody: RigidBody3D

func delete_this() -> void: 
	queue_free()
