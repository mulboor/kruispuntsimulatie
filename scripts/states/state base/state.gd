extends Node
class_name State

signal Transitioned(state: State, new_state_name: String)

func enter() -> void: 
	pass

func exit() -> void:
	pass
 
func update(_delta: float) -> void: 
	pass

func pysics_update(_delta: float) -> void: 
	pass
