extends Sprite2D

var toggle_track_overlay = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	z_index = 1
	z_as_relative = false
	
func _process(_delta: float) -> void:
	if toggle_track_overlay and GlobVar.results == false:
		z_index = 1000
	else:
		z_index = 1
	if Input.is_action_just_pressed("show_track"):
		toggle_track_overlay = !toggle_track_overlay
