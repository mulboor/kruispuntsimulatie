extends TrafficSignal
class_name TrafficLight

@export var green_time: float
@export var red_time: float
@export var start_at_red: bool

var cur_red_time: float
var cur_green_time: float

func _ready():
	pass

func _physics_process(delta):
	pass
