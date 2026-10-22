class_name PlayerAction
extends Resource
var unit: PlayerBattleUnit

@export var action_name: String
@export var action_point_cost: int = 1
@export var max_targeting_length: float = 300.0
@export var min_targeting_length: float = 0.0
@export var is_movement: bool = false
@export var is_blockable: bool = true

func action(_target):
	pass
