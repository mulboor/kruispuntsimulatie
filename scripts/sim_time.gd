extends Node
class_name SimTime

@export var frames_per_time_unit: int

@onready var current_time: int
@onready var current_frame: int

signal TimeChanged(cur_time: int)

func _ready() -> void:
	current_frame = 0

# Tel het aantal tijdseenheden
func _process(delta: float) -> void:
	if current_frame < frames_per_time_unit:
		current_frame += 1
	elif current_frame == frames_per_time_unit: 
		current_time += 1
		current_frame = 0 
		
		TimeChanged.emit(current_time)
