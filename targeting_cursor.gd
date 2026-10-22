extends Area2D
var target
@onready var current_target_indicator = %"Current Target Indicator"


func _process(_delta):
	global_position = get_global_mouse_position()


func _on_body_entered(body):
	target = body
	current_target_indicator.text = "Target: " + target.name
