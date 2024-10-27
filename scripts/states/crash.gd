extends MoverState
class_name Crash

@onready var parent_state: MoverState = $"../.."

signal Crashed(type: String)

func enter() -> void: 
	rigidbody = parent_state.rigidbody
	
	rigidbody.freeze = false
	Crashed.emit("vehicle")

func physics_update(_delta):
	if rigidbody.linear_velocity < Vector3(0.001, 0.001, 0.001) && rigidbody.angular_velocity < Vector3(0.001, 0.001, 0.001):
		Transitioned.emit(self, "deleteself")
