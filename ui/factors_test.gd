extends Control

var number = "Hello"

func _ready():
	print(number)
	number = 100
	print(number)

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/options_test.tscn")
	
	
