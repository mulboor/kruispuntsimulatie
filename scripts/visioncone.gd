extends Node3D
class_name VisionCone

@export var user_vars: RoadUserVars

@onready var rays: Array[RayCast3D]

@onready var objects_hit: Array[CollisionObject3D]

@onready var children: Array[Node]

signal HitObjects(objects: Array[CollisionObject3D])

func _ready() -> void: 
	# Vind all rays en zet ze in de array
	get_all_children(self)
	for child in children: 
		if child.get_class() == "RayCast3D":
			rays.append(child)
	
	# Zet de lengte van alle rays
	for ray: RayCast3D in rays: 
		ray.target_position.z = user_vars.visibility


func _physics_process(delta):
	# Zet alle geraakte objecten in de array en verzend ze
	for ray in rays: 
		if ray.get_collider() != null: 
			objects_hit.append(ray.get_collider())
	
	HitObjects.emit(objects_hit)

func get_all_children(search_node: Node) -> void: 
	for child: Node in search_node.get_children():
		get_all_children(child)
		children.append(child)
