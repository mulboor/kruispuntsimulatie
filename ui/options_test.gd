extends Control

func _on_factors_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/factors_test.tscn")


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/test.tscn")



	
