extends SubViewport


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.export_line.connect(_on_line_export)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_line_export(point_array: PackedVector2Array):
	print("Export Ran")
	$Line2D.width = 12
	$Line2D.points = point_array
	await RenderingServer.frame_post_draw
	var image: Image = get_texture().get_image()
	image.save_png("user://drawn_path.png")
	$Line2D.width = 50
	await RenderingServer.frame_post_draw
	var image_2 = get_texture().get_image()
	image_2.save_png("user://drawn_path_big.png")
	SignalBus.eval_path.emit()
