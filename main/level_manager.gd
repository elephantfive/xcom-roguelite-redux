class_name LevelManager
extends Node
const LEVEL_1 = preload("uid://cndrnqus88ybt")
const BATTLE_UNIT = preload("uid://e3wbfa7ftu2n")

@onready var unit_actions = %"Unit Actions"
@onready var turn_manager = %"Turn Manager"
@onready var targeting_cursor = %TargetingCursor
@onready var active_roster = %ActiveRoster
@onready var combat_hud = %CombatHUD
@onready var campaign_map_hud = %CampaignMapHUD

var active_level


func _ready():
	#load_level.call_deferred(LEVEL_1)
	pass


func load_level(level):
	var new_level = level.instantiate()
	add_child(new_level)
	active_level = new_level
	turn_manager.turn_list_reset()
	generate_units(new_level)
	generate_enemies()
	combat_hud.show()
	campaign_map_hud.hide()
	
#Pass "global" variables/nodes to new unit
func generate_units(new_level):
	for roster_unit in active_roster.get_children():
		for spawn_point in new_level.player_spawn_points.get_children():
			var new_unit = BATTLE_UNIT.instantiate()
			new_unit.targeting_cursor = targeting_cursor
			new_unit.unit = roster_unit.unit
			new_unit.unit_actions = unit_actions
			new_unit.global_position = spawn_point.global_position
			new_unit.turn_manager = turn_manager
			new_level.allies.add_child(new_unit)
			for enemy in active_level.enemies.get_children():
				enemy.targets.append(new_unit)
				if enemy.target == null:
					enemy.target = new_unit
			spawn_point.queue_free()
			break
			
#Add enemies to turn list
func generate_enemies():
	for enemy in active_level.enemies.get_children():
		turn_manager.turn_list.append(enemy)
		enemy.turn_manager = turn_manager
