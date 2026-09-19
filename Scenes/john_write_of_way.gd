extends AnimatedSprite2D


var murder = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.person_killed.connect(_on_murder)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	murder = clamp(murder-delta,0,1.5)
	if GlobVar.results == false:
		if murder > 0:
			animation = "murder"
		elif Input.is_action_pressed("backward"):
			animation = "back"
		elif Input.is_action_pressed("turn_right"):
			animation = "right"
		elif Input.is_action_pressed("turn_left"):
			animation = "left"
		elif Input.is_action_pressed("increase_speed"):
			animation = "forward"
		else:
			animation = "idle"
	else:
		if GlobVar.rank_displayed:
			animation = "rank"
			frame = GlobVar.rank
		else:
			animation = "idle"
	play()
		
		
		

func _on_murder():
	murder = 1.5
