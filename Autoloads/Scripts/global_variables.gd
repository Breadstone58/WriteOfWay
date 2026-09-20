extends Node

var save_path = "user://scores.save"

var kills: int = 0
var results: bool = false
var rank_displayed: bool = false
var rank: int = 0
var high_scores = [7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.reset_kills.connect(_on_kill_reset)
	SignalBus.person_killed.connect(_on_kill)

func _on_kill_reset():
	kills = 0
	
func _on_kill():
	kills += 1
	print(kills)

func save():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(high_scores)
	
func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		high_scores = file.get_var()
	else:
		high_scores = [7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7]
		
