extends State
class_name PlayerIdle

@onready var animated_sprite = $"../../AnimatedSprite2D"

func enter():
	animated_sprite.play("Idle")

func update(_delta : float):
	if Input.get_vector("Left", "Right", "Up", "Down"):
		state_transition.emit(self, "Moving")
	#if Input.is_action_just_pressed("Attack"):
		#state_transition.emit(self, "Attack")
