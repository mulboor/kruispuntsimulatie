extends Node3D
class_name VisionCone

@export_category("Ray cone")
@export var ray_cone_angle: float
@export var angle_between_rays: float
@export_category("Collision shape")

func _ready() -> void:	
	area.monitoring = true
	
	for child in get_children(): 
		if child is RayCast3D: 
			rays.append(child)
	
	print("Rays: ", rays)

func _physics_process(delta: float) -> void:
	# Detecteer andere weggebruikers met de grote cone
	var overlapped_bodies: Array[Node3D] = area.get_overlapping_bodies()
	for body in overlapped_bodies:
		if body.name != "Ground":
			var distance: float = parent.global_position.distance_to(body.position)
			non_ground_hit.emit(body, distance)
			break
	
	# Als er geen verkeerstekens en andere weggebruikers in grote cone zitten
	if no_significant_hits(overlapped_bodies): 
		no_hits.emit()
		print("no hits")
	
	# Check de rays voor een hit 
	for ray in rays: 
		if ray.get_collider() != null && ray.is_colliding(): 
			ray_hit.emit(ray.get_collider(), parent.global_position.distance_to(ray.get_collider().position))
			break

func sweep() -> void:
	pass

# Returns true als alleen de grond wordt geraakt
func no_significant_hits(bodies: Array[Node3D]) -> bool: 
	if bodies.size() == 1 && bodies[0].name == "Ground" && !ray_hits || bodies.size() == 0: 
		return true
	return false
