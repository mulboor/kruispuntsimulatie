extends State
class_name Crash

@export var rb: RigidBody3D

signal Crashed(type: String)

func enter() -> void: 
	rb.freeze = false
	Crashed.emit("vehicle")

func physics_update(_delta):
	pass
