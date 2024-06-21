extends State
class_name  PlayerMoving

@onready var animated_sprite= $"../../AnimatedSprite2D"
@export var move_speed := 100.0
var player : CharacterBody2D

func enter():
	player = get_tree().get_first_node_in_group("Player")	
func update(delta: float):
	animation_manage()
	
	if Input.is_action_just_pressed("Attack"):
		state_transition.emit(self, "Attack")
func physics_update(_delta: float):
	transform_input()
	
func transform_input():
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down").normalized()
	player.velocity = input_direction * move_speed

func animation_manage():
	if player.velocity.x != 0:
		if player.velocity.y < 0:
			animated_sprite.play("RunUpHorizontal")
		elif player.velocity.y > 0:
			animated_sprite.play("RunDownHorizontal")
		else:
			animated_sprite.play("RunHorizontal")
		animated_sprite.flip_h = true if player.velocity.x < 0 else false
	else:
		if player.velocity.y < 0:
			animated_sprite.play("RunUp")
		elif player.velocity.y > 0:
			animated_sprite.play("RunDown")
		else:
			state_transition.emit(self, "Idle")
