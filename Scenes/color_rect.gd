extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	

func _on_delete_save_button_button_down() -> void:
	position.x = 243
	position.y = 45


func _on_delete_save_button_down() -> void:
	GlobVar.high_scores = [7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7]
	GlobVar.save()
	position.x = -1593
	position.y = 39


func _on_dont_delete_save_button_down() -> void:
	position.x = -1593
	position.y = 39
