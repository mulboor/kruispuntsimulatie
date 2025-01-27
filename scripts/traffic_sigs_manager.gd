extends Node

@export var stoplicht : Node
@export var hinder_voor_stoplicht : Node
@export var stoplicht_aan : bool

func _ready():
	if stoplicht_aan: 
		hinder_voor_stoplicht.process_mode = Node.PROCESS_MODE_DISABLED
		stoplicht.process_mode = Node.PROCESS_MODE_INHERIT
	else: 
		hinder_voor_stoplicht.process_mode = Node.PROCESS_MODE_INHERIT
		stoplicht.process_mode = Node.PROCESS_MODE_DISABLED
