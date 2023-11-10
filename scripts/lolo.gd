extends CharacterBody2D

const BLOCK_SIZE = 100
const HALF_BLOCK_SIZE = BLOCK_SIZE/2;
const FRAMES_PER_MOVEMENT = 10;
const SPEED = HALF_BLOCK_SIZE/FRAMES_PER_MOVEMENT;

var isMoving = false;
var framesMoved = 0;
var direction = Vector2();

func _physics_process(delta):
	if not isMoving:
		# TODO might want multiple directions to cancel each other out
		if Input.is_action_pressed("move_left"):
			isMoving = true
			direction.x = -1
		elif Input.is_action_pressed("move_right"):
			isMoving = true
			direction.x = 1
		elif Input.is_action_pressed("move_up"):
			isMoving = true
			direction.y = -1
		elif Input.is_action_pressed("move_down"):
			isMoving = true
			direction.y = 1
	
	velocity.x = direction.x*SPEED;
	velocity.y = direction.y*SPEED;
	
	if isMoving:
		framesMoved = framesMoved + 1
		if framesMoved >= FRAMES_PER_MOVEMENT:
			isMoving = false;
			framesMoved = 0;
			direction.x = 0;
			direction.y = 0;
		
	var collision = move_and_collide(velocity)
	if collision:
		print("I collided with ", collision.get_collider().name)
