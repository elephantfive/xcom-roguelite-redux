class_name EnemyBattleUnit
extends CharacterBody2D
#region Initialization
@export var unit: EnemyUnit
var targets = []
var target
var turn_manager

@onready var sprite = $Sprite2D
@onready var unit_actions
@onready var label = $Label
@onready var navigation_agent = $NavigationAgent2D
@onready var state_chart = $StateChart

var current_action:EnemyAction
var active: bool = false
var init_pos: Vector2
var movement_destination: Vector2

var current_health: int
var movement_points: float
var distance_moved: float = 0.0

var debug_values: Dictionary

var movement_speed: float = 10000.0
#endregion

func _ready():
	debug_values = {
		"current_health" : current_health,
		"movement_points" : movement_points,
		"distance_moved" : distance_moved,
	}
	current_health = unit.max_health
	movement_points = unit.max_move_distance
	sprite.texture = unit.sprite_texture
	
	navigation_agent.path_desired_distance = 2.0
	navigation_agent.target_desired_distance = 2.0
	for action in unit.actions:
		action.unit = self

func turn_reset():
	distance_moved = 0.0

func process_turn():
	for potential_target in targets:
		if position.distance_to(potential_target.position) < position.distance_to(target.position):
			target = potential_target
			
	for action:EnemyAction in unit.actions:
		if action.action_name != 'move' and position.distance_to(target.position) <= action.max_targeting_length and position.distance_to(target.position) >= action.min_targeting_length:
			action.action()
			break
		elif action.action_name == 'move':
			action.action()
			break

func range_check():
	var viable_action:EnemyAction
	for action:EnemyAction in unit.actions:
		if action.action_name != 'move' and position.distance_to(target.position) <= action.max_targeting_length and position.distance_to(target.position) >= action.min_targeting_length:
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

	if distance_moved < movement_points and not range_check() and position.distance_to(target.position) > movement_points:
		velocity = new_velocity
	else:
		velocity = Vector2(0, 0)
		if range_check():
			state_chart.send_event('action')
		else:
			end_turn()
	move_and_slide()
	distance_moved += global_position.distance_to(last_position)
	last_position = global_position

func end_turn():
	state_chart.send_event('end_turn')
	turn_manager.advance_turn()


func _on_no_action_state_entered():
	turn_reset()
	for potential_target in targets:
		if position.distance_to(potential_target.position) < position.distance_to(target.position):
			target = potential_target
	if range_check():
		state_chart.send_event('action')
	else:
		state_chart.send_event('move')


func _on_other_action_state_entered():
	current_action.action()
	end_turn()
