extends State
class_name MobIdle

@onready var mob = $"../.."
@export var move_speed := 20.0
@onready var animated_sprite = $"../../AnimatedSprite2D"

var player : CharacterBody2D
var move_direction : Vector2
var wander_time : float


func randomize_wander():
	move_direction = Vector2(randf_range(-1,1), randf_range(-1,1)).normalized()
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
		mob.velocity = move_direction * move_speed
	var direction = player.global_position - mob.global_position
	
	if direction.length() < 50:
		state_transition.emit(self, "MobFollow")
	
	
