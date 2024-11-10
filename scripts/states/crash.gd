extends State
class_name Crash

signal Crashed(type: String)

@export var rigidbody: RigidBody3D

func enter() -> void: 
	rigidbody.freeze = false
	Crashed.emit("vehicle")

func physics_update(_delta):
	if rigidbody.linear_velocity < Vector3(0.001, 0.001, 0.001) && rigidbody.angular_velocity < Vector3(0.001, 0.001, 0.001):
		Transitioned.emit(self, "deleteself")
