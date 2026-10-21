class_name EnemyAction
extends Resource


@export var action_name: String
@export var action_point_cost: int = 1
var unit: EnemyBattleUnit
@export var max_targeting_length: float = 300.0
@export var min_targeting_length: float = 0.0

func action():
	pass
	
