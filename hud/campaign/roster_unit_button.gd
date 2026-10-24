class_name RosterUnitButton
extends Button
@onready var label = $Label
@onready var roster_manager = %"Roster Manager"

var unit:Unit

func _on_pressed():
	roster_manager.toggle_unit_activation(self)
	if label.text == '':
		for value in unit.transfer_values:
			label.text += (value + ': ' + str(unit.transfer_values[value]) + '\n')
	else:
		label.text = ''

func load_unit():
	icon = unit.texture
	
