extends Node3D
class_name VisionCone

@export var user_vars: RoadUserVars

@export var col_box_width: float 
@export var col_box_depth: float
@export var col_box_height: float

@export var col_shape: CollisionShape3D

@onready var area: Area3D = $Area3D

signal non_ground_hit(object_hit: Node, object_distance: float)
signal no_hits

func _ready() -> void:
	if is_instance_valid(user_vars):
		col_box_depth = user_vars.visibility
	
	var col_box: BoxShape3D = BoxShape3D.new()
	col_box.size.z = user_vars.visibility
	col_box.size.y = col_box_height
	col_box.size.x = col_box_width
	col_shape.set_shape(col_box)
	col_shape.position.z = -(user_vars.visibility / 2) # Omdat het zwaartepunt van col_shape in het midden zit
	
	area.monitoring = true

func _physics_process(delta: float) -> void:
	var overlapped_bodies: Array[Node3D] = area.get_overlapping_bodies()
	for body in overlapped_bodies:
		if body.name != "Ground":
			var distance: float = position.distance_to(body.position)
			non_ground_hit.emit(body, distance)
			break
	
	if overlapped_bodies.size() == 0: 
		no_hits.emit()
	
	print(global_position)
