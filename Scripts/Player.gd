extends KinematicBody2D

export var speed = 10.0
var velocity = 50
var fallMultiplier = 500
var direction = Vector2.ZERO

func _physics_process(delta):
	if not is_on_floor():
		velocity -= fallMultiplier * delta
	else:
		velocity /= 2
	move_and_slide(Vector2(0, -velocity), Vector2.UP)
	direction = Vector2(int(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left")),0)
	direction *= speed * 50 * delta
	if is_on_floor() and Input.is_action_just_pressed("Jump"):
		velocity += 500
	move_and_collide(direction)
	print(velocity)
	clamp(velocity, -1000, 1000)
