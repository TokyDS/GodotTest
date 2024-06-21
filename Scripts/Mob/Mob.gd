extends CharacterBody2D
class_name mob
@export var target : Node2D

func _ready():
	if !target:
		target = get_tree().get_first_node_in_group("Player")
func _physics_process(delta):

	move_and_slide()
