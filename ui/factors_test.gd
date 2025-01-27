extends Control

@onready var line_edit: LineEdit = $LineEdit
@onready var label: Label = $Label

func _ready():
	line_edit.text_submitted.connect(_on_LineEdit_text_entered)
	
	line_edit.text_submitted.connect(_on_LineEdit2_text_entered)
	
func _on_LineEdit_text_entered(new_text: String) -> void:
	label.text = "Your name is: " + new_text


func _on_LineEdit2_text_entered(new_text: String) -> void:
	label.text = "Your name is: " + new_text



	





func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/options_test.tscn")
	
	
