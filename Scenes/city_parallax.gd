extends Parallax2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	autoscroll.x = 1000 * Input.get_axis("turn_left", "turn_right")
