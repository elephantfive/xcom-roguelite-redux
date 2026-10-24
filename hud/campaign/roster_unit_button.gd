class_name RosterUnitButton
extends Button
@onready var label = $Label
@onready var roster_manager = %"Roster Manager"

var unit:Unit

func _on_pressed():
	if roster_manager.targeted_unit != self:
		roster_manager.targeted_unit = self
	else:
		roster_manager.targeted_unit = null
	label.text = ''
	if unit:
		for value in unit.transfer_values:
			label.text += (value + ': ' + str(unit.transfer_values[value]) + '\n')

func load_unit():
	icon = unit.texture
	
