extends TrafficSignal
class_name TrafficLight

@export var green_time: float
@export var red_time: float
@export var start_at_red: bool

var cur_red_time: float
var cur_green_time: float

func _ready():
	if start_at_red: 
		stop_at_signal = true
	else: 
		stop_at_signal = false
	
	cur_green_time = green_time 
	cur_red_time = red_time

func _physics_process(delta):
	if stop_at_signal && cur_red_time > 0: 
		cur_red_time -= delta
	else: 
		stop_at_signal = false
		cur_red_time = red_time
	
	if !stop_at_signal && cur_green_time > 0: 
		cur_green_time -= delta
	else:
		stop_at_signal = true
		cur_green_time = green_time
