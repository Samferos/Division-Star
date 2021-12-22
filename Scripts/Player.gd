extends KinematicBody2D

export var speed = 10.0
export var jumpForce = 5
export var fallMultiplier = 7
var velocity = 50
var direction = Vector2.ZERO
var jumps = 2
var onFloor = false
var previousSpeed

func _ready():
	previousSpeed = speed

func _physics_process(delta):
	if not is_on_floor():
		if onFloor and jumps == 2:
			velocity = 0
			onFloor = false
		velocity -= fallMultiplier * 60 * delta
	else:
		if onFloor:
			jumps = 2
		speed = previousSpeed
		onFloor = true
	move_and_slide(Vector2(0, -velocity), Vector2.UP)
	direction = Vector2(int(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left")),0)
	direction *= speed * 60 * delta
	if Input.is_action_just_pressed("Jump") and jumps == 2:
		onFloor = false
		jumps -= 1
		velocity = 60 * jumpForce
	elif Input.is_action_just_pressed("Jump") and jumps == 1:
		jumps -= 1
		previousSpeed = speed
		speed *= 2
		velocity = 60 * jumpForce * 0.25
	move_and_collide(direction)
	print(velocity)
