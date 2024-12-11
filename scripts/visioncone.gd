extends Node3D
class_name VisionCone

@export_category("Ray cone")
@export var ray_cone_angle: float
@export var angle_between_rays: float
@export var max_view_distance: float

@onready var rays: Array[RayCast3D]

signal ray_hit_obstacle()
signal no_ray_hits()

func _ready() -> void:	
	generate_raycasts()

func _physics_process(delta: float) -> void:
	check_rays()

func generate_raycasts() -> void: 
	var ray_count: float = ray_cone_angle / angle_between_rays
	 
	for i in range(ray_count): 
		var ray: RayCast3D = RayCast3D.new()
		var angle: float = angle_between_rays * (i - ray_count / 2.0)
		ray.target_position = Vector3(0.0, 0.0, -max_view_distance)
		ray.enabled = true
		ray.exclude_parent = true
		ray.rotation_degrees.y = angle
		add_child(ray)
		rays.append(ray)

func check_rays() -> void: 
	var ray_hits: int
	for ray in rays: 
		if ray.is_colliding() && ray.get_collider() != null: 
			ray_hits += 1
	
	if ray_hits > 0:
		ray_hit_obstacle.emit()
	else: 
		no_ray_hits.emit()
