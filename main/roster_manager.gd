class_name RosterManager
extends Node
const PLAYER_BLADE = preload("uid://cwodphqc46to5")

var targeted_unit: RosterUnitButton
@onready var active_roster = %ActiveRoster
@onready var inactive_roster = %InactiveRoster


func _ready():
	add_unit(PLAYER_BLADE)

func add_unit(unit:Unit):
	for roster_unit:RosterUnitButton in active_roster.get_children():
		if roster_unit.unit == null:
			roster_unit.unit = unit
			roster_unit.load_unit()
			break

func toggle_unit_activation(unit:RosterUnitButton):
	pass
