extends Node3D
class_name VisionCone

@export var ray_length: float

@onready var rays: Dictionary = {}

func _ready() -> void: 
	# Vind alle rays, zet hun lengte, en voeg ze toe aan rays
	for child in get_children():
		if child == RayCast3D:
			var ray: RayCast3D = child
			ray.target_position.x = ray_length
			rays[ray.name] = ray
