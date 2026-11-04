extends VBoxContainer

var reward: Resource
@onready var reward_description = $TextureDescriptionContainer/RewardDescription
@onready var reward_label = $RewardLabel

func _ready():
	reward_description.text = reward.reward_description
	if reward is Unit:
		reward_label.text = reward.unit_name
	elif reward is Artifact:
		pass
	elif reward is Item:
		pass

func _on_reward_button_pressed():
	get_parent().selected_reward = reward
