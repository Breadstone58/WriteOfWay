extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func get_input():
	if Input.is_action_just_pressed("increase_speed"):
		print("YOOO IM A RACCOON")
		$AnimationPlayer.play("BOOST")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	get_input()
	if GlobVar.results == false:
		var t_animation = "idle"
		
		if Input.is_action_pressed("turn_right"):
			t_animation = "right"
		elif Input.is_action_pressed("turn_left"):
			t_animation = "left"
		elif Input.is_action_pressed("forward"):
			t_animation = "forward"
		elif Input.is_action_pressed("backward"):
			t_animation = "backward"
		else:
			t_animation = "idle"
		if animation != t_animation:
			play(t_animation)
