class_name Unit
extends Resource

@export var unit_name: String

@export var max_health: int

@export var max_move_distance: float
@export var flying: bool = false

@export var max_default_attack_range: float = 5.0
@export var min_default_attack_range: float = 0.0

@export var actions: Array[PackedScene]

@export var texture: Texture2D
