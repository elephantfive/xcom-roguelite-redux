extends Button

var unit: PlayerBattleUnit
var action: PlayerAction

func _ready():
	text = action.action_name

func _on_pressed():
	unit.init_pos = unit.position
	unit.current_action = action
	if action.action_name == 'Move':
		unit.state_chart.send_event('target_move')
	elif action.action_name == 'End Turn':
		unit.state_chart.send_event('end_turn')
	else:
		unit.state_chart.send_event('target_action')
	
