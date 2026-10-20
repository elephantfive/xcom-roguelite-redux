extends Button

var turn_manager
var unit

@export var state_chart_event: String
@export var targeting_line_max_length: String
@export var targeting_line_min_length: String

func _on_pressed():
	unit.state_chart.send_event(state_chart_event)
	unit.init_pos = unit.position
	if targeting_line_max_length != '':
		unit.targeting_line.max_length = unit.get(targeting_line_max_length)
	if targeting_line_min_length != '':
		unit.targeting_line.min_length = unit.get(targeting_line_min_length)
	
