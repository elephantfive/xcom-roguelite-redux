extends VBoxContainer
@onready var reward_texture = $TextureDescriptionContainer/RewardTexture
@onready var reward_description = $TextureDescriptionContainer/RewardDescription
@onready var reward_label = $RewardLabel

var reward

func load_reward():
	reward_texture = reward.texture
	reward_label.text = reward.label
