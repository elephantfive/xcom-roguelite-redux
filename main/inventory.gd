class_name Inventory
extends Node

var item_inventory: Array[Item] = []
var artifact_inventory: Array[Artifact] = []

func add_item(item: Resource):
	if item is Item:
		item_inventory.append(item)
	elif item is Artifact:
		item_inventory.append(item)
