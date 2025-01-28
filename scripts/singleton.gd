extends Node

var avg_speed_singleton: float
var avg_vis_singleton: float
var avg_react_singleton: float
var traflights_singleton: bool

func set_speed(n: float) -> void: 
	avg_speed_singleton = n

func set_vis(n: float) -> void: 
	avg_vis_singleton = n

func set_react(n: float) -> void: 
	avg_react_singleton = n 

func set_traflights(v: bool) -> void:
	traflights_singleton = v
