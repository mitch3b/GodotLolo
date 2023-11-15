extends Area2D

const SPEED = 128;

var bullet_direction;

# Called when the node enters the scene tree for the first time.
func _ready():
	var lolo = get_node("../Lolo");
	bullet_direction = lolo.direction;
	print("bullet direction: " + str(bullet_direction));
	
	if bullet_direction.x > 0:
		rotation_degrees = -90;
	elif bullet_direction.x < 0:
		rotation_degrees = 90;
	elif bullet_direction.y < 0:
		rotation_degrees = 180;

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += SPEED * bullet_direction * delta
	print("bullet position: " + str(global_position));

func destroy2():
	print("destroying bullet...")
	queue_free()

func _on_loloBullet_area_entered(area):
	#destroy2();
	pass;

func _on_loloBullet_body_entered(body):
	#destroy2();
	pass;
