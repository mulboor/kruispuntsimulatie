extends Node3D
class_name VisionCone

@export_category("Ray cone")
@export var ray_cone_angle: float
@export var angle_between_rays: float
@export var max_view_distance: float
@export_category("Collision shape")

@onready var rays: Array[RayCast3D]

signal ray_hit_obstacle(object: Node3D)

func _ready() -> void:	
	generate_raycasts()

func _physics_process(delta: float) -> void:
	check_rays()

func generate_raycasts() -> void: 
	var ray_count: float = ray_cone_angle / angle_between_rays
	
	for i in range(ray_count): 
		var ray: RayCast3D = RayCast3D.new()
		var angle: float = angle_between_rays * (i - ray_count / 2.0)
		print("Angle: ", angle)
		ray.target_position = Vector3(0.0, 0.0, -max_view_distance)
		ray.rotation_degrees.y = angle
		add_child(ray)
		rays.append(ray)

func check_rays() -> void: 
	for ray in rays: 
		if ray.is_colliding(): 
			ray_hit_obstacle.emit(ray.get_collider())
			print("ray hit")
			break
