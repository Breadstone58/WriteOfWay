extends Parallax2D

var rotation_flip = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("backward"):
		rotation_flip = -1
	else:
		rotation_flip = 1
	autoscroll.x = 800 * Input.get_axis("turn_left", "turn_right") * rotation_flip
