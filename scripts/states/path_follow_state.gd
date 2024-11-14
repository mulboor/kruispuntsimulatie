extends State
class_name PathFollowState

@export var user_vars: RoadUserVars

@export var visioncone: VisionCone

@export var rigidbody: RigidBody3D

@onready var current_speed: float

func init_path_follow_state() -> void: 
	user_vars.path_follow.loop = false
	
	rigidbody.freeze_mode = RigidBody3D.FREEZE_MODE_KINEMATIC
	rigidbody.freeze = true
	rigidbody.contact_monitor = true
	rigidbody.max_contacts_reported = 10
	rigidbody.body_entered.connect(on_body_entered)
	
	visioncone.non_ground_hit.connect(on_non_ground_hit)

func on_body_entered(body: Node) -> void: 
	pass

func on_non_ground_hit(body: Node) -> void: 
	pass
