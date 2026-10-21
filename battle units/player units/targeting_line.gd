extends Line2D
var max_length: float
@onready var state_chart = $StateChart
@onready var battle_unit = $".."


func _on_valid_state_entered():
	default_color = Color(1, 1, 1)


func _on_too_long_state_entered():
	default_color = Color(1, 0, 0)

func _process(_delta):
	if battle_unit.current_targeting_line_length > max_length:
		state_chart.send_event('too_long')
	else:
		state_chart.send_event('valid')
