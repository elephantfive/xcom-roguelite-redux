class_name RosterManager
extends Node
const PLAYER_BLADE = preload("uid://cwodphqc46to5")

var targeted_unit: RosterUnitButton
@onready var active_roster = %ActiveRoster
@onready var inactive_roster = %InactiveRoster
@onready var activate_roster_unit = %ActivateRosterUnit


func _ready():
	add_unit(PLAYER_BLADE)

func add_unit(unit:Unit):
	for roster_unit:RosterUnitButton in active_roster.get_children():
		if roster_unit.unit == null:
			roster_unit.unit = unit
			roster_unit.load_unit()
			break

func toggle_unit_activation(unit:RosterUnitButton):
	if targeted_unit == unit:
		targeted_unit = null
		activate_roster_unit.hide()
	else:
		targeted_unit = unit
		activate_roster_unit.show()
		if targeted_unit in active_roster.get_children():
			activate_roster_unit.text = 'Remove unit from active roster.'
		else:
			activate_roster_unit.text = 'Add unit to active roster.'


func _on_activate_roster_unit_pressed():
	if targeted_unit in active_roster.get_children():
		active_roster.remove_child(targeted_unit)
		inactive_roster.add_child(targeted_unit)
	else:
		inactive_roster.remove_child(targeted_unit)
		active_roster.add_child(targeted_unit)
	targeted_unit = null
	activate_roster_unit.hide()
