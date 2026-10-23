extends Node

@export var active_unit_1: Unit

var active_roster = Array[Unit]
var inactive_roster = Array[Unit]

func _ready():
	active_roster.append(active_unit_1)
