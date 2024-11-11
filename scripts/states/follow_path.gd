extends State
class_name FollowPath

@export_category("Movement")
@onready var max_speed: float
@export var accel: float
var deccel: float

@export_category("Cognition")
@export var reaction_time: float

@export_category("Misc")
@export var rigidbody: RigidBody3D

@export var path_follow: PathFollow3D

@onready var follow_path: bool

@onready var current_speed: float

@onready var current_pos: Vector3
@onready var last_pos: Vector3

@onready var frame: int

func enter() -> void:
	path_follow.loop = false
	
	rigidbody.freeze_mode = RigidBody3D.FREEZE_MODE_KINEMATIC
	rigidbody.freeze = true
	rigidbody.contact_monitor = true
	rigidbody.max_contacts_reported = 10
	rigidbody.body_entered.connect(on_body_entered)
	
	follow_path = true

func physics_update(_delta: float) -> void:
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
	rigidbody.global_rotation = path_follow.global_rotation
	
	# Verwijder de auto als het pad voltooid is
	if path_follow.progress_ratio >= 1.0:
		Transitioned.emit(self, "deleteself")

func on_body_entered(body: Node) -> void: 
	if body.name != "Ground": 
		Transitioned.emit(self, "Crash")
