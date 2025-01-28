extends Control

@export var avg_speed_ui: LineEdit
@export var avg_reacton_ui: LineEdit
@export var avg_vis_ui: LineEdit
@export var traflights_ui: CheckBox

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/startmenu.tscn")

func _process(delta):
	Singleton.set_react(avg_speed_ui.get_text().to_float())
	
