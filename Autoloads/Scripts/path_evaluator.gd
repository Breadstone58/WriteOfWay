extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.eval_path.connect(_on_path_eval)
	
func _on_path_eval():
	print("Signal Called")
	var path: Image = load("res://Assets/Levels/level_0.png").get_image()
	var drawing: Image = load("res://drawn_path.png").get_image()
	
	var total_path_pixels: float = 0.0
	var accurate_player_pixels: float = 0.0
	var stray_player_pixels: float = 0.0

	for y in range(1296):
		for x in range(1296):
			var path_alpha = path.get_pixel(x, y).a
			var player_alpha = drawing.get_pixel(x, y).a
			
			var is_path_solid = path_alpha > 0.1
			var is_player_solid = player_alpha > 0.1

			if is_path_solid:
				total_path_pixels += 1.0
				
				if is_player_solid:
					accurate_player_pixels += 1.0
			
			elif is_player_solid:
				stray_player_pixels += 1.0

	var coverage_score = accurate_player_pixels / total_path_pixels
	var stray_penalty = stray_player_pixels / total_path_pixels
	stray_penalty = 0
	var raw_score = (coverage_score - stray_penalty) * 100.0
	var final_accuracy = clamp(raw_score, 0.0, 100.0)
	print(coverage_score)
	print(stray_penalty)
	print(final_accuracy)
