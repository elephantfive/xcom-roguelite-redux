class_name EnemyBattleUnit
extends BattleUnit
#region Initialization
var targets = []
#endregion

func _ready():
	debug_values = {
		"current_health" : current_health,
		"movement_points" : movement_points,
		"action_points": action_points,
	}
	
	set_values()
	init_navigation_agent()
	
	for action in unit.actions:
		action.unit = self


func viable_action_range_check():
	var viable_action:EnemyAction
	for action:EnemyAction in unit.actions:
		if action.action_name != 'move' and calculate_action_distance() <= action.max_targeting_length and calculate_action_distance() >= action.min_targeting_length and action.action_point_cost <= action_points:
			viable_action = action
	if viable_action:
		current_action = viable_action
		return true
	


func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target


func _on_moving_state_physics_processing(delta):
	set_movement_target(target.position)
	var last_position: Vector2 = global_position

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	var new_velocity = current_agent_position.direction_to(next_path_position) * movement_speed * delta

	if movement_points > 0 and not viable_action_range_check() and calculate_action_distance() > movement_points:
		velocity = new_velocity
	else:
		velocity = Vector2(0, 0)
		if viable_action_range_check():
			state_chart.send_event('action')
		else:
			end_turn()
	move_and_slide()
	movement_points -= global_position.distance_to(last_position)
	last_position = global_position

func end_turn():
	state_chart.send_event('end_turn')
	turn_manager.advance_turn()


func _on_no_action_state_entered():
	turn_reset()
	for potential_target in targets:
		if position.distance_to(potential_target.position) < position.distance_to(target.position):
			target = potential_target
	if viable_action_range_check():
		state_chart.send_event('action')
	else:
		state_chart.send_event('move')


func _on_other_action_state_entered():
	current_action.action()
	action_points -= current_action.action_point_cost
	end_turn()
