extends State
class_name MobFollow

@export var mob : CharacterBody2D
@export var move_speed := 40.0
var player : CharacterBody2D
@onready var navigation_agent_2d = $"../../NavigationAgent2D"

func enter(): 
	player = get_tree().get_first_node_in_group("Player")
#func seeker_setup():
	#await get_tree().physics_frame
	#if target:
		#navigation_agent_2d.target_position = target.global_position

func physics_update(delta : float):
	var direction = player.global_position - mob.global_position
	if direction.length() > 25: 
		mob.velocity = direction * move_speed * delta
	else:
		mob.velocity = Vector2()
	
	if direction.length() > 70:
		state_transition.emit(self, "MobIdle")


