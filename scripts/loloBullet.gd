extends Area2D

const SPEED = 256;
const BULLET_POSITION_OFFSET = 8;

var bullet_direction;

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Creating bullet...");
	var lolo = get_node("../Lolo");
	bullet_direction = lolo.direction;
	position = lolo.position;
	position.x += bullet_direction.x*BULLET_POSITION_OFFSET;
	position.y += bullet_direction.y*BULLET_POSITION_OFFSET;
	
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
	
func destroy2():
	print("Destroying bullet...")
	queue_free()
	

func _on_body_entered(body: Node2D):
	print("Bullet body entered by: " + body.name);
	if body.name == "Snakey":
		body.shoot(bullet_direction);
		
	destroy2();
	pass;


func _on_area_entered(area: Area2D):
	print("Bullet area entered by: " + area.name);
		
	destroy2();
	pass;
