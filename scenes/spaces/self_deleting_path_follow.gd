extends PathFollow3D
class_name SelfDeletingPathFollow3D

@onready var delete_time: float = 15
@onready var current_delete_time: float 

func _ready() -> void: 
	current_delete_time = delete_time

# Verwijder deze node zodat het niet ophoopt in de scene
func _physics_process(delta) -> void:
	current_delete_time -= delta
	if current_delete_time <= 0: 
		queue_free()
