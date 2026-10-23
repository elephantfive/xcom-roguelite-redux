class_name PlayerAction
extends Resource
var unit: PlayerBattleUnit

@export var action_name: String
@export var action_point_cost: int = 1
@export var state_chart_event: String = 'target_action'

@export var max_targeting_length: float = 300.0
@export var min_targeting_length: float = 0.0
@export var targeting_radius: float = 0.0

@export var is_aoe: bool = false
@export var is_nav_target: bool = false
@export var is_blockable: bool = true

@export var necessary_conditions: Array

@export var effects: Array[PlayerActionEffect]

func apply_effects(target):
	for effect in effects:
		if effect.instant:
			effect.apply_effect(target)
		else:
			target.effects.append(effect)
