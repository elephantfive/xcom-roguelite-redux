extends Node2D
@onready var label = $Label
@onready var enemy_unit = $".."



func _process(_delta):
	label.text = ''
	for value in enemy_unit.debug_values:
		label.text += str(value) + ": " + str(enemy_unit.get(value)) + "\n"
