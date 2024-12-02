extends PathFollow3D
class_name SelfDeletingPathFollow3D

@onready var timer: float = 100

# Verwijder deze node zodat het niet ophoopt in de scene
func _physics_process(delta) -> void:
	timer -= delta
	if progress_ratio >= 1 || timer <= 0: 
		queue_free()
