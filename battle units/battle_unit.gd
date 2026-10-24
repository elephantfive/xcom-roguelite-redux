class_name BattleUnit
extends CharacterBody2D

@export var unit: Unit
@onready var sprite:Sprite2D = $Sprite2D
@onready var state_chart = $StateChart
@onready var blocked_checker:RayCast2D = $BlockedChecker
@onready var label:Label = $Label
@onready var navigation_agent:NavigationAgent2D = $NavigationAgent2D
@onready var unit_actions

var actions: Array
var targeting_cursor: Area2D
var effects = []
var target
var targets = []
var current_action
var turn_manager: TurnManager
var texture: Texture2D
var init_pos: Vector2
var movement_destination: Vector2
var action_points: int
var current_health: int
var movement_points: float
var movement_speed: float = 10000.0
var debug_values: Dictionary

func init_navigation_agent():
	navigation_agent.path_desired_distance = 2.0
	navigation_agent.target_desired_distance = 2.0

#Values to be used from unit resource
func set_values():
	for value in unit.transfer_values:
		self.set(value, unit.get(value))
		
	sprite.texture = texture

func turn_reset():
	action_points = unit.action_points
	movement_points = unit.movement_points
	for effect in effects:
		if (effect.has("timer") and effect.timer > 0) or not effect.has("timer"):
			effect.apply_effect()
		if (effect.has("timer") and effect.timer > 0):
			effect.timer -= 1
			

func calculate_action_distance():
	var action_range: float = 0
	if current_action and current_action.action_name == 'move':
		set_movement_target(target.position)
		var _next_path_position: Vector2 = navigation_agent.get_next_path_position()
		for i in range(navigation_agent.get_current_navigation_path().size() - 1):
			action_range += (navigation_agent.get_current_navigation_path()[i].distance_to(navigation_agent.get_current_navigation_path()[i + 1]))
	else:
		action_range = position.distance_to(target.position)
	return action_range 

func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target

func end_turn():
	state_chart.send_event('end_turn')
	turn_manager.advance_turn()
