extends VBoxContainer

var reward: Resource

func _on_reward_button_pressed():
	get_parent().selected_reward = reward
