class_name CampaignMapLocation
extends Button
@onready var popup = $Popup
@export var level: PackedScene
@onready var level_manager = %"Level Manager"
@onready var campaign_map = %CampaignMap

func _on_pressed():
	popup.show()


func _on_exit_pressed():
	popup.hide()


func _on_level_start_pressed():
	level_manager.load_level(level)
	popup.hide()
	campaign_map.hide()
