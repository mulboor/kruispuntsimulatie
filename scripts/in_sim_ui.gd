extends Node

@export var speed: Label
@export var zicht: Label
@export var upm: Label
@export var reactie_s: Label
@export var trafligt: Label
@export var tijd: Label
@export var crashes: Label

@onready var t: float
@onready var t_string: String
@onready var crash_string: String

func _ready():
	var speed_string: String = "Gemiddelde autosnelheid: " + str(Singleton.avg_speed_singleton)
	speed.set_text(speed_string)
	var zicht_string: String = "Gemiddeld zichtvermogen: " + str(Singleton.avg_vis_singleton)
	zicht.set_text(zicht_string)
	var upm_string: String = "Verkeersdoorstroming: " + str(Singleton.upm_singleton)
	upm.set_text(upm_string)
	var reactie_string: String = "Gemiddelde reactietijd: " + str(Singleton.avg_react_singleton)
	reactie_s.set_text(reactie_string)
	
	if Singleton.traflights_singleton: 
		trafligt.set_text("Stoplichten: AAN")
	else: 
		trafligt.set_text("Stoplichten: UIT")

func _physics_process(delta):
	t += delta
	t_string = "Verlopen tijd: " + str(roundi(t))
	tijd.set_text(t_string)
	
	crash_string = "Verongelukte mensen: " + str(Singleton.crashes)
	crashes.set_text(crash_string)


func _on_terug_pressed():
	get_tree().change_scene_to_file("res://ui/startmenu.tscn")
