extends MoverState
class_name FollowPath

var follow_path: bool

var current_speed: float

@onready var parent_state: MoverState = $"../.."

func enter() -> void:
	# Zet de waardes gelijk aan de waardes van de ouder
	rigidbody = parent_state.rigidbody
	max_speed = parent_state.max_speed
	accel = parent_state.accel
	path_follow = parent_state.path_follow
	
	path_follow.loop = false
	
	# Bevries de rigidbody zodat later de positie direct aangepast kan worden.
	rigidbody.freeze = true
	rigidbody.contact_monitor = true
	rigidbody.max_contacts_reported = 3
	
	follow_path = true

func physics_update(_delta: float) -> void:
	var last_position: Vector3 = path_follow.global_position
	
	# Laat snelheid toenemen tot de max_speed. 
	if follow_path:
		if current_speed < max_speed:
			current_speed += accel
		else:
			current_speed = max_speed
		
		# Laat de pahtfollow over het pad lopen. 
		path_follow.progress += current_speed
	
	# Zet de positie van de auto gelijk aan die van de path_follow. 
	# Niet op de y want dan zou het de grond in gaan. 
	rigidbody.global_position.z = path_follow.global_position.z
	rigidbody.global_position.x = path_follow.global_position.x
	rigidbody.rotation = path_follow.rotation
	
	# Verwijder de auto als het pad voltooid is
	if path_follow.progress_ratio >= 1.0:
		Transitioned.emit(self, "deleteself")
	
	var current_position: Vector3 = path_follow.global_position
	rigidbody.linear_velocity = calc_velocity(_delta, last_position, current_position)
	print(last_position - current_position)

func update(_delta: float) -> void:
	# Check of we gecrasht zijn, zoja switch dan van state.
	for bodies in rigidbody.get_colliding_bodies():
		if bodies.name != "Ground":
			Transitioned.emit(self, "Crash")

func calc_velocity(t: float, last_pos: Vector3, cur_pos: Vector3) -> Vector3:
	var x: float = (cur_pos.x - last_pos.x) / t
	var y: float = (cur_pos.y - last_pos.y) / t
	var z: float = (cur_pos.z - last_pos.z) / t
	return Vector3(x, y, z)
