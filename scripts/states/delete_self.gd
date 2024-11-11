extends State
class_name DeleteSelf

@export var countdown: float 
@export var parent: Node

@onready var current_countdown: float

func enter() -> void:
	current_countdown = countdown

func physics_update(_delta) -> void:
	countdown -= _delta
	
	if countdown <= 0.0:
		delete()

func delete() -> void: 
	parent.queue_free()
