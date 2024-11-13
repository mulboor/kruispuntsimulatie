extends State
class_name FollowPath

@export var user_vars: RoadUserVars

@export var visioncone: VisionCone

@export var rigidbody: RigidBody3D

@export var road_user: Node3D

@onready var follow_path: bool

@onready var current_speed: float
@onready var current_reaction_time: float

func enter() -> void:
	user_vars.path_follow.loop = false
	
	rigidbody.freeze_mode = RigidBody3D.FREEZE_MODE_KINEMATIC
	rigidbody.freeze = true
	rigidbody.contact_monitor = true
	rigidbody.max_contacts_reported = 10
	rigidbody.body_entered.connect(on_body_entered)
	
	follow_path = true

func physics_update(_delta: float) -> void:
	if follow_path:
		accelerate()
	else: 
		current_reaction_time -= _delta
		deccelerate()
	
	# Zet de positie van de auto gelijk aan die van de path_follow. 
	# Niet op de y want dan zou het de grond in gaan. 
	road_user.global_position.z = user_vars.path_follow.global_position.z
	road_user.global_position.x = user_vars.path_follow.global_position.x
	road_user.global_rotation = user_vars.path_follow.global_rotation
	
	# Verwijder de auto als het pad voltooid is
	if user_vars.path_follow.progress_ratio >= 0.99:
		road_user.queue_free()

func accelerate() -> void: 
	# Laat snelheid toenemen tot de max_speed
	if current_speed < user_vars.max_speed:
		current_speed += user_vars.accel
	else:
		current_speed = user_vars.max_speed
	
	# Laat de pahtfollow over het pad lopen. 
	user_vars.path_follow.progress += current_speed

func deccelerate() -> void: 
	if current_reaction_time <= 0: 
			current_speed -= user_vars.deccel
			if current_speed > 0: 
				user_vars.path_follow.progress += current_speed

func on_body_entered(body: Node) -> void: 
	if body.name != "Ground": 
		Transitioned.emit(self, "Crash")

func on_objects_spotted(bodies: Array[CollisionObject3D]) -> void:
	for body in bodies: 
		if is_instance_valid(body):
			if body.name != "Ground": 
				follow_path = false
				break
	
	if bodies.is_empty(): 
		follow_path = true
