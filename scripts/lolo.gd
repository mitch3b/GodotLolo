extends CharacterBody2D

const loloBullet = preload("res://scenes/loloBullet.tscn")

const BLOCK_SIZE = 16
const HALF_BLOCK_SIZE = BLOCK_SIZE/2;
const FRAMES_PER_MOVEMENT = 8;
const SPEED = HALF_BLOCK_SIZE/FRAMES_PER_MOVEMENT;

var isMoving = false;
var framesMoved = 0;
var direction = Vector2();
var currentBullet;

func _ready():
	direction.x = 0;
	direction.y = 1;
	$AnimatedSprite2D.animation = "default";
	
func shootBullet():
	print("Lolo direction: " + str(direction))
	if currentBullet: 
		currentBullet.destroy2();
		
	print("Shooting bullet...");
	currentBullet = loloBullet.instantiate();
	currentBullet.position = position;

	get_parent().add_child(currentBullet);
	print("bullet shot!")

func _process(delta):
	print("lolo position: " + str(position));

	###########
	# Moving
	###########
	if not isMoving:
		# TODO might want multiple directions to cancel each other out
		if Input.is_action_pressed("move_left"):
			isMoving = true
			direction.x = -1
			direction.y = 0
			$AnimatedSprite2D.play();
		elif Input.is_action_pressed("move_right"):
			isMoving = true
			direction.x = 1
			direction.y = 0
			$AnimatedSprite2D.play();
		elif Input.is_action_pressed("move_up"):
			isMoving = true
			direction.x = 0
			direction.y = -1
			$AnimatedSprite2D.play();
		elif Input.is_action_pressed("move_down"):
			isMoving = true
			direction.x = 0
			direction.y = 1
			$AnimatedSprite2D.play();

	# TODO I screwed up something about how things move
	if isMoving:
		velocity.x = direction.x*SPEED;
		velocity.y = direction.y*SPEED;
		
		framesMoved = framesMoved + 1
		if direction.y > 0:
			$AnimatedSprite2D.animation = "down";
		elif direction.y < 0:
			$AnimatedSprite2D.animation = "up";
		elif direction.x > 0:
			$AnimatedSprite2D.animation = "left";
			$AnimatedSprite2D.flip_h = true;
		elif direction.x < 0:
			$AnimatedSprite2D.animation = "left";
			$AnimatedSprite2D.flip_h = false;

		if framesMoved >= FRAMES_PER_MOVEMENT:
			isMoving = false;
			framesMoved = 0;
	else:
		velocity.x = 0;
		velocity.y = 0;
		$AnimatedSprite2D.stop();
		
	var collision = move_and_collide(velocity)
	if collision:
		print("I collided with ", collision.get_collider().name)
		
	##########
	# Actions
	##########
	
	if Input.is_action_just_pressed("shoot_button"):
		# TODO if bullet is available
		shootBullet();
		
		
		
