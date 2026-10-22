extends Line2D
var length: float = 0
var is_blockable: bool = false
var max_length: float
var min_length: float
@onready var state_chart = $StateChart
@onready var battle_unit = $".."
@onready var blocked_checker = $"../BlockedChecker"


func _on_valid_state_entered():
	default_color = Color(1, 1, 1)


func _on_too_long_state_entered():
	state_chart.send_event('invalid')
	default_color = Color(1, 0, 0)


func _on_blocked_state_entered():
	default_color = Color(1.0, 1.0, 0.0, 1.0)

func _process(_delta):
	state_chart.send_event('valid')
	length = 0
	for point in points.size() - 1:
		length += points[point].distance_to(points[point + 1])
		
	if  length > max_length or length < min_length:
		state_chart.send_event('invalid_length')
	else:
		state_chart.send_event('valid_length')
		
	if is_blockable and blocked_checker.get_collider():
		state_chart.send_event('blocked')
	else:
		state_chart.send_event('not_blocked')
	

func create_points(ability_max_length:float, ability_is_movement:bool = false, ability_is_blockable:bool = true):
	#Reset targeting line and set origin at self, target at mouse
	max_length = ability_max_length
	is_blockable = ability_is_blockable
	clear_points()
	add_point(battle_unit.init_pos - global_position)
	blocked_checker.target_position = get_global_mouse_position() - global_position
	
	#If movement, use navigation pathfinding
	if ability_is_movement:
		battle_unit.set_movement_target(get_global_mouse_position())
		if battle_unit.navigation_agent.is_navigation_finished():
			return
		#Add points to line and distance between points to current travel distance
		for point in battle_unit.navigation_agent.get_current_navigation_path():
			add_point(point - global_position)
			
	#Otherwise simple point a > point b targeting and distance calculation
	else:
		add_point(get_global_mouse_position() - global_position)
