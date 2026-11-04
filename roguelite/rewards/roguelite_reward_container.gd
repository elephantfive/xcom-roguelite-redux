extends VBoxContainer

@export var rewards: Array[Resource]
var selected_reward

const REWARD = preload("uid://u7tq6sykfl5m")
@onready var button = $Button
@onready var roster_manager = %"Roster Manager"

func _ready():
	for reward in rewards:
		var new_reward = REWARD.instantiate()
		new_reward.reward = reward
		add_child(new_reward)
	button.move_to_front()

func acquire_reward():
	if selected_reward is Item:
		pass
	elif selected_reward is Artifact:
		pass
	elif selected_reward is Unit:
		roster_manager.add_unit(selected_reward)
	queue_free()


func _on_button_pressed():
	acquire_reward()
