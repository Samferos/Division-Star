extends KinematicBody2D

export var playerID := 1
export var speed = 10.0
export var jumpForce = 5
export var fallMultiplier = 7
var yVelocity = 0
var direction = Vector2.ZERO
var jumps = 1
var onFloor = false

func _physics_process(delta):
	if not is_on_floor():
		onFloor = false
		yVelocity -= fallMultiplier * 60 * delta
	else:
		if onFloor:
			yVelocity = 0
			jumps = 2
		onFloor = true
	move_and_slide(Vector2(0, -yVelocity), Vector2.UP)
	direction = Vector2(int(Input.is_action_pressed("right_player" + String(playerID))) - int(Input.is_action_pressed("left_player" + String(playerID))),0)
	direction *= speed * 60 * delta
	if Input.is_action_just_pressed("Jump") and jumps > 0:
		onFloor = false
		jumps -= 1
		yVelocity = 60 * jumpForce
	move_and_collide(direction)
	
	clamp(yVelocity, -1000, 1000)
	print(yVelocity)
	
func _process(delta):
	if direction == Vector2.ZERO:
		$Sprite.animation = "idle"
	elif direction.x < 0:
		$Sprite.animation = "side"
		$Sprite.flip_h = false
	elif direction.x > 0:
		$Sprite.animation = "side"
		$Sprite.flip_h = true
