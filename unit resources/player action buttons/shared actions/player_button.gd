extends Button

var unit

@export var state_chart_event: String
@export var action_point_cost: int = 1
@export var max_ability_range: float
@export var min_ability_range: float

func _on_pressed():
	unit.state_chart.send_event(state_chart_event)
	unit.init_pos = unit.position

	
