class_name BattleUnit
extends CharacterBody2D

@export var unit: Unit
@onready var sprite:Sprite2D = $Sprite2D
@onready var state_chart = $StateChart
@onready var blocked_checker:RayCast2D = $BlockedChecker
@onready var label:Label = $Label
@onready var navigation_agent:NavigationAgent2D = $NavigationAgent2D
@onready var unit_actions

var target
var current_action
var turn_manager
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
	var value_list = [
		"current_health",
		"movement_points",
		"action_points",
		"texture",
	]
	
	for value in value_list:
		self.set(value, unit.get(value))
		
	sprite.texture = texture

func turn_reset():
	movement_points = unit.movement_points

func calculate_action_distance():
	var action_range: float = 0
	if current_action.action_name == 'move':
		set_movement_target(target.position)
		var _next_path_position: Vector2 = navigation_agent.get_next_path_position()
		for i in range(navigation_agent.get_current_navigation_path().size() - 1):
			action_range += (navigation_agent.get_current_navigation_path()[i].distance_to(navigation_agent.get_current_navigation_path()[i + 1]))
	else:
		action_range = position.distance_to(target.position)
	return action_range 

func set_movement_target(_target):
	pass
