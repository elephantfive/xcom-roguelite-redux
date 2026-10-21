class_name AllyBattleUnit
extends BattleUnit
#region Initialization
@export var unit: PlayerUnit
@onready var targeting_line = $"Targeting Line"
var current_targeting_line_length: float = 0.0
#endregion

func _ready():
	debug_values = {
		"current_health" : current_health,
		"movement_points" : movement_points,
		"current_targeting_line_length" : current_targeting_line_length,
	}
	
	set_values(unit)
	init_navigation_agent()
	create_action_buttons()



func targeting_line_create(max_length):
	#Reset targeting line and set origin at self, target at mouse
	current_targeting_line_length = 0
	targeting_line.max_length = max_length
	targeting_line.clear_points()
	targeting_line.add_point(init_pos - global_position)
	set_movement_target(get_global_mouse_position())

	if navigation_agent.is_navigation_finished():
		return
	#Add points to line and distance between points to current travel distance
	for point in navigation_agent.get_current_navigation_path():
		targeting_line.add_point(point - global_position)
	for i in range(navigation_agent.get_current_navigation_path().size() - 1):
		current_targeting_line_length += (navigation_agent.get_current_navigation_path()[i].distance_to(navigation_agent.get_current_navigation_path()[i + 1]))

func create_action_buttons():
	for action in unit.actions:
		var new_action = action.instantiate()
		new_action.unit = self
		unit_actions.add_child(new_action)

func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target

#region State Processing
func _on_move_state_processing(_delta):
	targeting_line_create(movement_points)


func _on_move_state_input(event):
	if event.is_action_pressed('left_click'):
		state_chart.send_event('move')


func _on_moving_state_physics_processing(delta):
	if navigation_agent.is_navigation_finished():
		state_chart.send_event('no_action')
		return

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * movement_speed * delta
	move_and_slide()


func _on_moving_state_entered():
	movement_points -= current_targeting_line_length
	current_targeting_line_length = 0


func _on_targeting_state_entered():
	targeting_line.show()


func _on_targeting_state_exited():
	targeting_line.hide()


func _on_targeting_state_input(event):
	if event.is_action_pressed('right_click'):
		state_chart.send_event('no_action')
#endregion


func _on_player_turn_state_exited():
	turn_manager.advance_turn()


func _on_player_turn_state_entered():
	turn_reset(unit)
