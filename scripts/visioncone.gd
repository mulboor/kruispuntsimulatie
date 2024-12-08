extends Node3D
class_name VisionCone

@onready var rays: Array[RayCast3D] 
@onready var area: Area3D = $Visionarea

@onready var ray_hits: bool

signal non_ground_hit(object_hit: Node, object_distance: float)
signal area_hit(area_hit: Node, area_distance: float)
signal ray_hit(object_hit: CollisionObject3D, object_distance: float)
signal no_hits

func _ready() -> void:	
	area.monitoring = true
	
	for child in get_children(): 
		if child is RayCast3D: 
			rays.append(child)

func _physics_process(delta: float) -> void:
	# Detecteer andere weggebruikers met de grote cone
	var overlapped_bodies: Array[Node3D] = area.get_overlapping_bodies()
	for body in overlapped_bodies:
		if body.name != "Ground":
			var distance: float = global_position.distance_to(body.position)
			non_ground_hit.emit(body, distance)
			break
	
	# Detecteer verkeerstekens met de grote cone
	var overlapped_areas: Array[Area3D] = area.get_overlapping_areas()
	print(overlapped_areas)
	for area in overlapped_areas:
		if area is TrafficSignal && area.name != "Visionarea":
			var traffic_signal: TrafficSignal = area
			var distance: float = global_position.distance_to(area.position)
			if traffic_signal.stop_for_signal:
				area_hit.emit(area, distance)
				break
	
	# Als er geen verkeerstekens en andere weggebruikers in grote cone zitten
	if no_significant_hits(overlapped_bodies): 
		no_hits.emit()
		print("no hits")
	
	# Check de ray 
	for ray in rays: 
		print("Collider: ", ray.get_collider())
		if ray.is_colliding() && ray.get_collider() != null: 
			ray_hit.emit(ray.get_collider(), global_position.distance_to(ray.get_collider().position))
			print("gezien")
	
	print("Rays: ", rays)

func sweep() -> void:
	pass

func check_rays_hit(rays: Array[RayCast3D]) -> void: 
	for ray in rays: 
		if ray.is_colliding() && ray.get_collider() != null: 
			ray_hit.emit(ray.get_collider(), global_position.distance_to(ray.get_collider().position))
			break

# Returns true als alleen de grond wordt geraakt
func no_significant_hits(bodies: Array[Node3D]) -> bool: 
	if bodies.size() == 1 && bodies[0].name == "Ground" && !ray_hits || bodies.size() == 0: 
		return true
	return false
