extends Node

@export var lights: Array[TrafficSignal]

@export var green_time: float

var cur_green_time: float

var index: int

func _ready(): 
	cur_green_time = green_time

func _physics_process(delta):
	cur_green_time -= delta
	if cur_green_time <= 0: 
		if index != lights.size() - 1: 
			index += 1
		else: 
			index = 0
		cur_green_time = green_time
	
	for light in lights:
		if light.get_index() != index:
			light.stop_at_signal = true
			light.wait_at_signal = false
		else: 
			light.stop_at_signal = false
