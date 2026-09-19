extends Node2D

var goal_times = {
	"level_0": INF,
	"level_1": 6,
	"level_2": 30,
	"level_3": 90,
	"level_4": 90,
}
var level_name = {
	"level_0": "Mona Lisa",
	"level_1": "Level 1: Yield to Pedestrians",
	"level_2": "",
	"level_3": "",
	"level_4": "",
}
var stop_count = false
var time_elapsed: float = 0.0
var time_bonus = 100
var rank = ""
var fade_out = false
var fade_alpha = 0

@onready var clip: Sprite2D = $Clipboard
@onready var fade_box: ColorRect = $FadeBox
@onready var timer_disp: RichTextLabel = $Display/TimerDisp
@onready var time_goal: RichTextLabel = $Display/TimeGoalDisp
@onready var level_name_disp: RichTextLabel = $Display/LevelNameDisp

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.level_start.emit()
	SignalBus.results.connect(_on_results)
	clip.visible = false
	if goal_times[get_tree().current_scene.name] != INF:
		time_goal.text = "Goal: "+str(int(goal_times[get_tree().current_scene.name]/60)) + ":" + str(int(goal_times[get_tree().current_scene.name]) % 60).pad_zeros(2)
	else:
		time_goal.text = "Goal: Finish"
	level_name_disp.text = level_name[get_tree().current_scene.name]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !stop_count:
		time_elapsed += delta
	if fade_out:
		fade_alpha = clamp(fade_alpha+delta, 0, 0.75)
		fade_box.color = Color(0,0,0,fade_alpha)
	timer_disp.text = str(int(time_elapsed/60)) + ":" + str(int(time_elapsed) % 60).pad_zeros(2)
	if int(time_elapsed) > goal_times[get_tree().current_scene.name]:
		time_goal.self_modulate = Color(0,0,0,0.35)
	
func _on_results(base_score: int):
	fade_out = true
	stop_count = true
	var ped_deduct = GlobVar.kills * 50
	if int(time_elapsed) > goal_times[get_tree().current_scene.name]:
		time_bonus = 0
	var final_score = clamp(base_score - ped_deduct + time_bonus, 0, 1000)
	if final_score == 1000 and ped_deduct == 0 and time_bonus == 100:
		rank = "P"
	elif final_score >= 900 and base_score >= 900:
		rank = "S"
	elif final_score >= 900:
		rank = "A"
	elif final_score >= 800:
		rank = "B"
	elif final_score >= 700:
		rank = "C"
	elif final_score >= 600:
		rank = "D"
	else:
		rank = "F"
	print(final_score)
	print(rank)
	
	
