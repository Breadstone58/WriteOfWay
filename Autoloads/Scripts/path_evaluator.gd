extends Node

var layout_dictionary = {
	"level_0": "mona_lisa.png",
	"level_1": "line.png",
	"level_2": "square.png",
	"level_3": "spiral.png",
	"level_4": "zig_zag.png",
	"level_5": "square_spiral.png",
	"level_6": "triangle.png",
	"level_7": "pentagon.png",
	"level_8": "curve.png",
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.eval_path.connect(_on_path_eval)
	
func _on_path_eval():
	var path_pattern = layout_dictionary[get_tree().current_scene.name]
	var path: Image = load("res://Assets/Levels/"+path_pattern).get_image()
	var drawing: Image = Image.load_from_file("user://drawn_path.png")
	var drawing_big: Image = Image.load_from_file("user://drawn_path_big.png")
	
	var path_pixels: float = 0.0
	var drawing_pixels: float = 0.0
	var same_pixels: float = 0.0
	
	for x in range(1296):
		for y in range(1296):
			if path.get_pixel(x,y) == Color(0,0,0):
				path_pixels += 1
			if drawing.get_pixel(x,y) == Color(0,0,0):
				drawing_pixels += 1
			if path.get_pixel(x,y) == Color(0,0,0) and drawing_big.get_pixel(x,y) == Color(0,0,0):
				same_pixels += 1
	
	var Percent_Error: float = (abs(path_pixels - drawing_pixels)/drawing_pixels)
	#print(path_pixels)
	#print(drawing_pixels)
	#print(1-Percent_Error)
	#print(same_pixels / path_pixels)
	var raw_score = min(1-Percent_Error,same_pixels/path_pixels)
	var base_score = clamp(int(round(raw_score * 1000)),0,1000)
	print(raw_score)
	SignalBus.results.emit(base_score)
