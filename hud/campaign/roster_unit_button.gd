extends Button
@onready var label = $Label

@export var unit:Unit

func _ready():
	icon = unit.texture


func _on_pressed():
	pass
