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
var current_health: int
var movement_points: float
var distance_moved: float = 0.0
var movement_speed: float = 10000.0
var debug_values: Dictionary

func set_values(unit):
	#Values to be used from unit resource
	var value_list = [
		"current_health",
		"movement_points",
		"texture",
	]
	
	for value in value_list:
		self.set(value, unit.get(value))
		
	sprite.texture = texture
