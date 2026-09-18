extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.eval_path.connect(_on_path_eval)
	
func _on_path_eval():
	#get_tree().current_scene.name
	var path: Image = Image.load_from_file("res://Assets/Levels/level_0.png")
	var drawing: Image = Image.load_from_file("res://drawn_path.png")
	var metrics = path.compute_image_metrics(drawing,false)
	print(metrics)
