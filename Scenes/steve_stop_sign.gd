extends AnimatedSprite2D

var timer = Timer.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation = "idle"
	SignalBus.person_killed.connect(_on_murder)
	SignalBus.results.connect(_on_results)
	add_child(timer)
	
	timer.wait_time = 6
	timer.one_shot = false
	timer.autostart = true
	timer.timeout.connect(_on_timer)
	timer.start()

func _on_timer() -> void:
	if animation == "idle":
		animation = ["breathe","drophat","flipclipboard","writing"][randi_range(0,3)]
		frame = 0
		play()
		await animation_finished
		animation = "idle"
		frame = 0


func _on_murder():
	stop()
	animation = "eyes"
	play()
	await animation_finished
	animation = "idle"
	frame = 0

func _on_results(_base_score : float):
	print("Steve")
	timer.queue_free()
	stop()
	animation = "writing_results"
	play()

func _process(_delta: float) -> void:
	if GlobVar.rank_displayed == true:
		stop()
		if GlobVar.rank == 6:
			animation = "eyes"
		else:
			animation = "idle"
