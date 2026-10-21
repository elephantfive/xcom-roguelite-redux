class_name Unit
extends Resource

@export var unit_name: String

@export var max_health: int
@export var current_health: int

@export var action_points: int = 1
@export var movement_points: float = 300
@export var flying: bool = false

@export var max_default_attack_range: float = 5.0
@export var min_default_attack_range: float = 0.0


@export var texture: Texture2D
