extends Node

@export var frames_per_time_unit: int

@onready var current_time: int
@onready var current_frame: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_frame = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_frame < frames_per_time_unit:
		current_frame += 1
	elif current_frame == frames_per_time_unit: 
		current_time += 1
		current_time = 0 
