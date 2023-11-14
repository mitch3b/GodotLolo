extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

const MAX_PIVOT_PIXELS = 16;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
	return
