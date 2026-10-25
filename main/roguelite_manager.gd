class_name RogueliteManager
extends Node
@onready var reward_container = $"Roguelite Layer/RewardContainer"
const ROGUELITE_REWARD_CONTAINER = preload("uid://dydcc3l3l8vjf")

var rewards: Array = []

func load_rewards():
	for child in reward_container.get_children():
		child.queue_free()
	for reward in rewards:
		append_reward(reward)

func append_reward(reward):
	var new_container = ROGUELITE_REWARD_CONTAINER.instantiate()
	new_container.reward = reward
	new_container.load_reward()
	reward_container.add_child(new_container)
