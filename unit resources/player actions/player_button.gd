extends Button

var unit: PlayerBattleUnit
var action: PlayerAction

func _ready():
	text = action.action_name

func _on_pressed():
	unit.init_pos = unit.position
	unit.current_action = action
	unit.state_chart.send_event(action.state_chart_event)
	
