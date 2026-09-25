extends AudioStreamPlayer

@export var tracks: Array[AudioStream] = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# play_song()
	SignalBus.level_select.connect(_level_select_entered)
	SignalBus.level_start.connect(_level_start)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _level_select_entered():
	# play_song()
	pass

func play_song():
	if playing == false:
		stream = tracks[0]
		play()
		await finished
		stream = tracks[1]
		play()
		
func _level_start():
	stop()
