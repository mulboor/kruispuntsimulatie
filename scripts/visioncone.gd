extends Node3D
class_name VisionCone

@onready var area: Area3D = $Area3D

signal non_ground_hit(object_hit: Node, object_distance: float)
signal area_hit(area_hit: Node, area_distance: float)
signal no_hits

func _ready() -> void:	
	area.monitoring = true

func _physics_process(delta: float) -> void:
	# Detecteer andere weggebruikers
	var overlapped_bodies: Array[Node3D] = area.get_overlapping_bodies()
	var traffic_signals: Array[TrafficSignal]
	for body in overlapped_bodies:
		if body.name != "Ground":
			traffic_signals.append(body)
			var distance: float = position.distance_to(body.position)
			non_ground_hit.emit(body, distance)
			break
	
	# Detecteer verkeerstekens
	var overlapped_areas: Array[Area3D] = area.get_overlapping_areas()
	print(overlapped_areas)
	for area in overlapped_areas:
		if area is TrafficSignal:
			var traffic_signal: TrafficSignal = area
			var distance: float = position.distance_to(area.position)
			if traffic_signal.stop_for_signal:
				area_hit.emit(area, distance)
				break
	
	# Als er geen verkeerstekens en andere weggebruikers in de weg zitten
	if no_significant_hits(overlapped_bodies): 
		no_hits.emit()
		print("no hits")

func sweep() -> void:
	pass

# Returns true als alleen de grond wordt geraakt
func no_significant_hits(bodies: Array[Node3D]) -> bool: 
	if bodies.size() <= 1 && bodies[0].name == "Ground": 
		return true
	return false
