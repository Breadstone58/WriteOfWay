extends Node

var kills: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.reset_kills.connect(_on_kill_reset)
	SignalBus.person_killed.connect(_on_kill)

func _on_kill_reset():
	kills = 0
	
func _on_kill():
	kills += 1
	print(kills)
