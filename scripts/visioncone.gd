extends Node3D
class_name VisionCone

@export var ray_length: float

@onready var rays: Array[RayCast3D]

@onready var objects_hit: Array[CollisionObject3D]

signal HitObjects(objects: Array[CollisionObject3D])

func _ready() -> void: 
	# Vind alle rays, zet hun lengte gelijk aan de ray length, en voeg ze toe aan de dictionary
	for child in get_children():
		if child == RayCast3D:
			var ray: RayCast3D = child
			ray.target_position.x = ray_length
			rays.append(ray)

func _physics_process(delta):
	# Zet alle geraakte objecten in de array en verzend ze
	for ray in rays: 
		if ray.get_collider() != null: 
			objects_hit.append(ray.get_collider())
	
	HitObjects.emit(objects_hit)
