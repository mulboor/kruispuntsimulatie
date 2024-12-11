extends State
class_name PathFollowState

@export var user_vars: RoadUserVars

@export var visioncone: VisionCone

@export var rigidbody: RigidBody3D

@export var traffic_signal_detection_area: Area3D

func init_state() -> void: 
	user_vars.path_follow.loop = false
	
	rigidbody.freeze_mode = RigidBody3D.FREEZE_MODE_KINEMATIC
	rigidbody.freeze = true
	rigidbody.contact_monitor = true
	rigidbody.max_contacts_reported = 10
	rigidbody.body_entered.connect(on_body_entered)
	
	visioncone.ray_hit_obstacle.connect(on_vis_ray_hit)
	visioncone.no_ray_hits.connect(on_vis_ray_no_hits)
	visioncone.max_view_distance = user_vars.visibility
	
	traffic_signal_detection_area.monitoring = true
	traffic_signal_detection_area.area_entered.connect(on_area_entered)

func on_body_entered(body: Node) -> void: 
	if body.name != "Ground": 
		Transitioned.emit(self, "Crash")

func on_area_entered(area: Area3D) -> void: 
	pass

func on_vis_ray_no_hits() -> void: 
	pass

func on_vis_ray_hit() -> void: 
	pass

func set_position_to(pos: Vector3, rot: Vector3) -> void:  
	user_vars.global_position.z = pos.z
	user_vars.global_position.x = pos.x
	user_vars.global_rotation = rot
