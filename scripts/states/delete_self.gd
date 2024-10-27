extends State
class_name DeleteSelf

@export var countdown: float 

@onready var current_countdown: float

@onready var parent_state: MoverState = $"../.."


func enter() -> void:
	current_countdown = countdown

func physics_update(_delta) -> void:
	countdown -= _delta
	
	if countdown <= 0.0:
		delete()

func delete() -> void: 
	parent_state.delete_this()
