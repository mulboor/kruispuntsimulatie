extends Node
class_name StateMachine

@export var inital_state: State

var current_state: State

var states: Dictionary = {}

func _ready() -> void: 
	# Vind alle states die deze statemachine beheert en zet ze in de lijst.
	for child in get_children():
		print("fop")
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
			print("fap")
	
	if inital_state != null:
		inital_state.enter()
		current_state = inital_state

func _physics_process(delta) -> void:
	print(current_state)
	if current_state != null: 
		current_state.physics_update(delta)

func _process(delta) -> void:
	if current_state != null:
		current_state.update(delta) 

func on_child_transition(state, new_state_name: String) -> void:
	# Verander van state. Wordt gecalled vanuit de state zelf. 
	print("yoooo")
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if new_state == null:
		print("null")
		return
	
	if current_state != null:
		current_state.exit()
	
	new_state.enter()
	
	current_state = new_state
