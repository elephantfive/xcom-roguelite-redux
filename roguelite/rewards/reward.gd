extends VBoxContainer

var reward: Resource
var reward_container


func _on_reward_button_pressed():
	reward_container.selected_reward = reward
