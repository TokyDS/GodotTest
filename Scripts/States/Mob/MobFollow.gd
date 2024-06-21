extends State
class_name MobFollow

@export var mob : CharacterBody2D
@export var move_speed := 40.0
var player : CharacterBody2D
@onready var navigation_agent_2d = $"../../NavigationAgent2D"

func enter():
	player = get_tree().get_first_node_in_group("Player")
	call_deferred("seeker_setup")
	
func seeker_setup():
	await get_tree().physics_frame
	if player:
		navigation_agent_2d.target_position = player.global_position

func physics_update(delta : float):
	if player:
		navigation_agent_2d.target_position = player.global_position
	if navigation_agent_2d.is_navigation_finished():
		return
	
	var current_agent_position = mob.global_position
	var next_path_position = navigation_agent_2d.get_next_path_position()
	
	var direction = player.global_position - mob.global_position
	var new_velocity = current_agent_position.direction_to(next_path_position) * move_speed
	
	if navigation_agent_2d.avoidance_enabled:
		navigation_agent_2d.set_velocity(new_velocity)
	else:
		_on_navigation_agent_2d_velocity_computed(new_velocity)
		
	if direction.length() > 160:
		navigation_agent_2d.target_position = mob.global_position
		state_transition.emit(self, "MobIdle")




func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	mob.velocity = safe_velocity
	
	pass # Replace with function body.
