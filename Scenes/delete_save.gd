extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobVar.load_data()
	var score_total = 0
	for i in GlobVar.high_scores:
		score_total += i
	print(score_total)
	if score_total != 140:
		position.x = 1471
		position.y = 1214
	else:
		position.x = -360
		position.y = 1076


func _on_delete_save_button_down() -> void:
	position.x = -360
	position.y = 1076
