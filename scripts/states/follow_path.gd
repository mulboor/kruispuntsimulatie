extends State
class_name FollowPath

@export var user_vars: RoadUserVars

@export var rigidbody: RigidBody3D

@onready var follow_path: bool

@onready var current_speed: float

func enter() -> void:
	user_vars.path_follow.loop = false
	
	# Bevries de rigidbody zodat later de positie direct aangepast kan worden.
	rigidbody.freeze = true
	rigidbody.contact_monitor = true
	rigidbody.max_contacts_reported = 3
	
	follow_path = true

func physics_update(_delta: float) -> void:
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
	rigidbody.global_position.z = user_vars.path_follow.global_position.z
	rigidbody.global_position.x = user_vars.path_follow.global_position.x
	rigidbody.rotation = user_vars.path_follow.rotation
	
	# Verwijder de auto als het pad voltooid is
	if user_vars.path_follow.progress_ratio >= 1.0:
		Transitioned.emit(self, "deleteself")
	
	# Check of we gecrasht zijn, zoja switch dan van state.
	for bodies in rigidbody.get_colliding_bodies():
		if bodies.name != "Ground":
			Transitioned.emit(self, "Crash")
