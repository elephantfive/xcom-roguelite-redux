extends Button

var unit

@export var state_chart_event: String
@export var action_point_cost: int = 1

func _on_pressed():
	unit.state_chart.send_event(state_chart_event)
	unit.init_pos = unit.position

	
