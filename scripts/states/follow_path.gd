extends State
class_name FollowPath

@export var user_vars: RoadUserVars

@export var rigidbody: RigidBody3D

@onready var follow_path: bool

@onready var current_speed: float

@onready var current_pos: Vector3
@onready var last_pos: Vector3

@onready var frame: int

func enter() -> void:
	user_vars.path_follow.loop = false
	
	rigidbody.contact_monitor = true
	rigidbody.max_contacts_reported = 10
	rigidbody.body_entered.connect(on_body_entered)
	
	follow_path = true

func physics_update(_delta: float) -> void:
	print(rigidbody.linear_velocity)
	if frame == 0 || frame % 2 == 0: 
		current_pos = user_vars.path_follow.global_position
	else: 
		last_pos = user_vars.path_follow.global_position
	
	# Laat snelheid toenemen tot de max_speed. 
	if follow_path:
		if current_speed < user_vars.max_speed:
			current_speed += user_vars.accel
		else:
			current_speed = user_vars.max_speed
		
		# Laat de pahtfollow over het pad lopen. 
		user_vars.path_follow.progress += current_speed
	
	# Zet de positie van de auto gelijk aan die van de path_follow. 
	# Niet op de y want dan zou het de grond in gaan. 
	rigidbody.linear_velocity.z = (current_pos.z - last_pos.z) / _delta
	rigidbody.linear_velocity.x = user_vars.path_follow.global_position.x
	rigidbody.global_rotation = user_vars.path_follow.global_rotation
	
	# Verwijder de auto als het pad voltooid is
	if user_vars.path_follow.progress_ratio >= 1.0:
		Transitioned.emit(self, "deleteself")

func on_body_entered(body: Node) -> void: 
	if body.name != "Ground": 
		Transitioned.emit(self, "Crash")
