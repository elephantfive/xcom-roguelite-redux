extends Node
@onready var level_manager = %"Level Manager"

#Player turn is 0. They are always at the first index of the turn list
var current_turn = 0
var turn_list = ["player"]

func turn_list_reset():
	current_turn = 0
	turn_list = ["player"]

func advance_turn():
	#If it is the last enemy's turn, reset to player turn
	if current_turn == turn_list.size() - 1:
		current_turn = 0
		for ally in level_manager.active_level.allies.get_children():
			ally.state_chart.send_event('begin_turn')
			
	#Otherwise, begin the next enemy's turn
	else:
		current_turn += 1
	if current_turn != 0:
		for enemy in level_manager.active_level.enemies.get_children():
				if turn_list[current_turn] == enemy:
					enemy.state_chart.send_event('begin_turn')
