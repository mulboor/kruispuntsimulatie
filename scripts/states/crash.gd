extends State
class_name Crash

@export var rigidbody: RigidBody3D
@export var road_user: Node
@export var delete_timer: float

@onready var current_delete_timer: float

func enter() -> void: 
	rigidbody.freeze = false
	current_delete_timer = delete_timer
	Singleton.add_crash()

func physics_update(_delta):
	current_delete_timer -= _delta
	if current_delete_timer <= 0 && is_instance_valid(road_user): 
		road_user.queue_free()
