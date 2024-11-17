extends State
class_name PathFollowState

@export var user_vars: RoadUserVars

@export var visioncone: VisionCone

@export var rigidbody: RigidBody3D

func init_path_follow_state() -> void: 
	user_vars.path_follow.loop = false
	
	rigidbody.freeze_mode = RigidBody3D.FREEZE_MODE_KINEMATIC
	rigidbody.freeze = true
	rigidbody.contact_monitor = true
	rigidbody.max_contacts_reported = 10
	rigidbody.body_entered.connect(on_body_entered)
	
	visioncone.non_ground_hit.connect(on_non_ground_hit)

func on_body_entered(body: Node) -> void: 
	if body.name != "Ground": 
		Transitioned.emit(self, "Crash")

func on_non_ground_hit(body: Node, distance: float) -> void: 
	pass

func set_position_to(node: Node) -> void:  
	user_vars.global_position.z = node.global_position.z
	user_vars.global_position.x = node.global_position.x
	user_vars.global_rotation = node.global_rotation
