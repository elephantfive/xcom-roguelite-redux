extends Area2D
var target


func _process(_delta):
	global_position = get_global_mouse_position()


func _on_body_entered(body):
	target = body
