class_name Unit
extends Resource

@export var unit_name: String

@export var actions: Array[Resource]
@export var action_points: int = 1

@export var max_health: int
@export var current_health: int

@export var movement_points: float = 300.0
@export var flying: bool = false

@export var texture: Texture2D

@export_multiline var reward_description: String

var transfer_values = {
	'unit_name': unit_name,
	
	'actions': actions,
	'action_points': action_points,
	
	'max_health': max_health,
	'current_health': current_health,
	
	'movement_points': movement_points,
	'flying': flying,
	
	'texture': texture,
}
