extends CharacterBody2D
#region Initialization
@export var unit: Unit
@onready var targeting_line = $"Targeting Line"

@onready var sprite = $Sprite2D
@onready var unit_actions
@onready var state_chart = $StateChart
@onready var label = $Label
@onready var navigation_agent = $NavigationAgent2D

var turn_manager
var active: bool = false
var init_pos: Vector2
var movement_destination: Vector2

var current_health: int
var movement_points: float
var distance_moved: float = 0.0
var current_distance: float = 0.0

var debug_values: Dictionary

var movement_speed: float = 10000.0
#endregion

func _ready():
	debug_values = {
		"current_health" : current_health,
		"movement_points" : movement_points,
		"distance_moved" : distance_moved,
		"current_distance" : current_distance,
	}
	current_health = unit.max_health
	movement_points = unit.max_move_distance
	sprite.texture = unit.sprite_texture
	
	navigation_agent.path_desired_distance = 2.0
	navigation_agent.target_desired_distance = 2.0
	
	create_action_buttons()

func turn_reset():
	movement_points = unit.max_move_distance

func targeting_line_create():
	current_distance = 0
	targeting_line.clear_points()
	targeting_line.add_point(init_pos - global_position)
	set_movement_target(get_global_mouse_position())

	if navigation_agent.is_navigation_finished():
		return
		
	for point in navigation_agent.get_current_navigation_path():
		targeting_line.add_point(point - global_position)
	for i in range(navigation_agent.get_current_navigation_path().size() - 1):
		current_distance += (navigation_agent.get_current_navigation_path()[i].distance_to(navigation_agent.get_current_navigation_path()[i + 1]))

func create_action_buttons():
	for action in unit.actions:
		var new_action = action.instantiate()
		new_action.unit = self
		new_action.turn_manager = turn_manager
		unit_actions.add_child(new_action)

func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target

#region State Processing
func _on_move_state_processing(_delta):
	targeting_line_create()

func set_default_targeting_line():
	targeting_line.points = PackedVector2Array([init_pos - global_position, get_global_mouse_position() - global_position])


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
	movement_points -= current_distance
	current_distance = 0


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
	turn_reset()
