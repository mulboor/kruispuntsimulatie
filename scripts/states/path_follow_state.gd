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
	
	visioncone.ray_hit_obstacle.connect(on_vis_ray_hit)
	visioncone.no_ray_hits.connect(on_vis_no_ray_hit)

func on_body_entered(body: Node) -> void: 
	if body.name != "Ground": 
		Transitioned.emit(self, "Crash")

func on_vis_no_ray_hit() -> void: 
	pass

func on_vis_ray_hit() -> void: 
	pass

func set_position_to(pos: Vector3, rot: Vector3) -> void:  
	user_vars.global_position.z = pos.z
	user_vars.global_position.x = pos.x
	user_vars.global_rotation = rot
