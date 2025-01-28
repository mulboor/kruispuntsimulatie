extends Control

@export var avg_speed_ui: LineEdit
@export var avg_reacton_ui: LineEdit
@export var avg_vis_ui: LineEdit
@export var traflights_ui: CheckBox
@export var upm_ui: LineEdit

var trafl: bool

func _ready():
	trafl = false

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/startmenu.tscn")

func _process(delta):
	Singleton.set_react(avg_reacton_ui.get_text().to_float())
	Singleton.set_speed(avg_speed_ui.get_text().to_float())
	Singleton.set_vis(avg_vis_ui.get_text().to_float())
	Singleton.set_upm(upm_ui.get_text().to_float())
	Singleton.set_traflights(trafl)

func _on_check_box_toggled(toggled_on):
	if !trafl:
		trafl = true
	else: 
		trafl = false
