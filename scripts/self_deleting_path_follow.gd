extends PathFollow3D
class_name SelfDeletingPathFollow3D

# Verwijder deze node zodat het niet ophoopt in de scene
func _physics_process(delta) -> void:
	if progress_ratio >= 1: 
		queue_free()
