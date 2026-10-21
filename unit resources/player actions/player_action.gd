class_name PlayerAction
extends Resource
var unit: PlayerBattleUnit

@export var action_name: String
@export var action_point_cost: int = 1
@export var max_targeting_length: float = 300.0
@export var min_targeting_length: float = 0.0

func action(target):
	pass
