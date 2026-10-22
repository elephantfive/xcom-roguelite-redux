class_name PlayerBattleUnit
extends BattleUnit
#region Initialization
@onready var targeting_line = $"Targeting Line"
const PLAYER_BUTTON = preload("uid://dnhwmqk8t65lg")
#endregion

func _ready():
	debug_values = {
		"current_health" : current_health,
		"movement_points" : movement_points,
	}
	
	set_values()
	init_navigation_agent()
	create_action_buttons()

func create_action_buttons():
	for action in unit.actions:
		var new_action_button = PLAYER_BUTTON.instantiate()
		new_action_button.action = action
		new_action_button.unit = self
		unit_actions.add_child(new_action_button)

func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target

#region State Processing
func _on_move_state_processing(_delta):
	targeting_line.create_points(current_action.max_targeting_length, current_action.is_movement, current_action.is_blockable)


func _on_move_state_input(event):
	if event.is_action_pressed('left_click'):
		state_chart.send_event('execute_move')


func _on_moving_state_physics_processing(delta):
	if navigation_agent.is_navigation_finished():
		state_chart.send_event('no_action')
		return

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * movement_speed * delta
	move_and_slide()


func _on_moving_state_entered():
	movement_points -= targeting_line.length
	targeting_line.length = 0


func _on_targeting_state_entered():
	targeting_line.show()


func _on_targeting_state_exited():
	targeting_line.hide()


func _on_targeting_state_input(event):
	if event.is_action_pressed('right_click'):
		state_chart.send_event('no_action')
#endregion


func _on_player_turn_state_exited():
	end_turn()


func _on_player_turn_state_entered():
	turn_reset()


func _on_non_move_action_state_input(event):
	if event.is_action_pressed('left_click'):
		state_chart.send_event('execute_action')


func _on_execute_non_move_action_state_entered():
	if action_points >= current_action.action_point_cost:
		current_action.action(targeting_cursor.target)
		action_points -= current_action.action_point_cost
	state_chart.send_event('no_action')


func _on_non_move_action_state_physics_processing(_delta):
	targeting_line.create_points(current_action.max_targeting_length, current_action.is_movement, current_action.is_blockable)
