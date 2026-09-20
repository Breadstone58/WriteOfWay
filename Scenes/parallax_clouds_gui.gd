extends Parallax2D


@export var base_speed: float = 0.0
var rotation_flip = 1
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("backward"):
		rotation_flip = -1
	else:
		rotation_flip = 1
	autoscroll.x = base_speed + 800 * Input.get_axis("turn_left", "turn_right") * rotation_flip
