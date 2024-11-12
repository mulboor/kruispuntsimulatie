extends Node3D
class_name VisionCone

@export var user_vars: RoadUserVars

@onready var rays: Array[RayCast3D]

@onready var objects_hit: Array[CollisionObject3D]

signal HitObjects(objects: Array[CollisionObject3D])

func _ready() -> void: 
	# Vind alle rays, zet hun lengte gelijk aan de ray length, en voeg ze toe aan de dictionary
	find_rays(self)
	print(rays)

func _physics_process(delta):
	# Zet alle geraakte objecten in de array en verzend ze
	for ray in rays: 
		if ray.get_collider() != null: 
			objects_hit.append(ray.get_collider())
	
	HitObjects.emit(objects_hit)

func find_rays(search_node: Node) -> void: 
	for child in search_node.get_children():
		if child != RayCast3D: 
			find_rays(child)
		elif child == RayCast3D: 
			print(child.name)
