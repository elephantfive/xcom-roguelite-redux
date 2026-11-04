extends VBoxContainer
@onready var reward_texture = $TextureDescriptionContainer/RewardTexture
@onready var reward_description = $TextureDescriptionContainer/RewardDescription
@onready var reward_label = $RewardLabel

var reward
var selected_reward
var roster_manager: RosterManager

func load_reward():
	reward_texture = reward.texture
	reward_description.text = reward.reward_description

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
