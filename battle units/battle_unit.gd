class_name BattleUnit
extends CharacterBody2D

@onready var sprite = $Sprite2D
@onready var state_chart = $StateChart
@onready var label = $Label
@onready var navigation_agent = $NavigationAgent2D
@onready var unit_actions

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
func set_values(unit):
	var value_list = [
		"current_health",
		"movement_points",
		"action_points",
		"texture",
	]
	
	for value in value_list:
		self.set(value, unit.get(value))
		
	sprite.texture = texture

func turn_reset(unit):
	movement_points = unit.movement_points
