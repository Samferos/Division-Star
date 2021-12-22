extends KinematicBody2D

var velocity = 0.0
var direction = Vector2.ZERO

func _physics_process(delta):
	if not is_on_floor():
		velocity += 0.2
	move_and_collide(Vector2(0, velocity))
	direction = Vector2(int(Input.is_action_pressed("Left")), int(Input.is_action_pressed("Left")))
