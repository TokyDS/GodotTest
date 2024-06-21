extends State
class_name MobIdle

@onready var mob = $"../.."
@export var move_speed := 20.0
@onready var animated_sprite = $"../../AnimatedSprite2D"
@onready var navigation_agent_2d = $"../../NavigationAgent2D"

var player : CharacterBody2D
var next_wander_point : Vector2
var wander_time : float


func randomize_wander():
	navigation_agent_2d.set_velocity(Vector2.ZERO)
	wait(2.0)
	next_wander_point = mob.global_position + Vector2(randf_range(-100,100), randf_range(-100,100))
	wander_time = randf_range(1, 3)

func enter():
	player = get_tree().get_first_node_in_group("Player")
	randomize_wander()
	animated_sprite.play("Idle")

func update(delta : float):
	if wander_time > 0:
		wander_time -= delta
	else: 
		randomize_wander()

func physics_update(delta: float):	
	if mob:
		var new_velocity = mob.global_position.direction_to(next_wander_point) * move_speed
		navigation_agent_2d.set_velocity(new_velocity)
	var direction = player.global_position - mob.global_position
	
	if direction.length() < 100:
		state_transition.emit(self, "MobFollow")

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
