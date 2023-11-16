extends CharacterBody2D

const EGG_FLY_SPEED = 8;
const TIME_TO_RESPAWN = 128;

enum { GREEN, EGG, SHOT, RESPAWNING}
var state;
var timeToSpawn;
var originalPosition;

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.animation = "default";
	state = GREEN;
	originalPosition = position;

const MAX_PIVOT_PIXELS = 16;

func destroy():
	print("Destroying Snakey...")
	queue_free();

func shoot(direction):
	print("Snakey Shot! Currently in state: " + str(state));
	if state == EGG:
		# TODO fly off screen and start a timer to respawn
		state = SHOT;
		velocity.x = direction.x*EGG_FLY_SPEED;
		velocity.y = direction.y*EGG_FLY_SPEED;
		set_collision_mask_value(2, false);
	elif state == GREEN:
		state = EGG;
		$AnimatedSprite2D.animation = "egg";
		set_collision_mask_value(2, true);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state == GREEN:
		# TODO probably want something more global
		var player_pos = get_node("../Lolo").get_global_position();
		var x_diff = position.x - player_pos.x;
		if x_diff > MAX_PIVOT_PIXELS:
			$AnimatedSprite2D.set_frame_and_progress(0, 0);
		elif x_diff > 0:
			$AnimatedSprite2D.set_frame_and_progress(1, 0);
		elif x_diff < -MAX_PIVOT_PIXELS:
			$AnimatedSprite2D.set_frame_and_progress(3, 0);
		else:
			$AnimatedSprite2D.set_frame_and_progress(2, 0);	
	elif state == SHOT:
		var collision = move_and_collide(velocity)
		if collision:
			print("Flying snakey egg collided with: " + collision.get_collider().name + " at: " + str(collision.get_position()));
			position.y = -64; # hide off screen
			state = RESPAWNING;
			timeToSpawn = 0;
	elif state == RESPAWNING:
		timeToSpawn += 1;
		if timeToSpawn > TIME_TO_RESPAWN:
			state = GREEN;
			position = originalPosition;
			$AnimatedSprite2D.animation = "default"
	
	return

