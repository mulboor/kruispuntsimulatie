extends State
class_name PathFollowState

@export var user_vars: RoadUserVars

@export var visioncone: VisionCone

@export var rigidbody: RigidBody3D

@export var col_shape: CollisionShape3D

func init_state() -> void: 
	user_vars.path_follow.loop = false
	
	col_shape.disabled = false
	rigidbody.freeze_mode = RigidBody3D.FREEZE_MODE_KINEMATIC
	rigidbody.freeze = true
	rigidbody.contact_monitor = true
	rigidbody.max_contacts_reported = 10
	rigidbody.body_entered.connect(on_body_entered)
	
	visioncone.non_ground_hit.connect(on_vis_non_ground_hit)
	visioncone.no_hits.connect(on_vis_no_hits)
	visioncone.area_hit.connect(on_vis_area_hit)

func on_body_entered(body: Node) -> void: 
	if body.name != "Ground": 
		Transitioned.emit(self, "Crash")

func on_vis_non_ground_hit(body: Node, distance: float) -> void: 
	pass

func on_vis_no_hits() -> void: 
	pass

func on_vis_area_hit(area: Node, distance: float) -> void:
	pass

func set_position_to(node: Node) -> void:  
	user_vars.global_position.z = node.global_position.z
	user_vars.global_position.x = node.global_position.x
	user_vars.global_rotation = node.global_rotation
