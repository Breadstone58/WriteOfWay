extends Node2D

var goal_times = {
	"level_0": INF,
	"level_1": 6,
	"level_2": 30,
	"level_3": 90,
	"level_4": 90,
	"level_5": 45,
}
var level_name = {
	"level_0": "Mona Lisa",
	"level_1": "Level 1: Yield to Pedestrians",
	"level_2": "",
	"level_3": "",
	"level_4": "",
	"level_5": "",
}
var stop_count = false
var time_elapsed: float = 0.0
var time_bonus = 100
var rank = ""
var fade_out = false
var fade_alpha = 0
var spawn_text = false
var spawn_text_speed_mult = 1
var spawn_score = false
var final_score = 0

@onready var clip: Sprite2D = $Clipboard
@onready var fade_box: ColorRect = $FadeBox
@onready var timer_disp: RichTextLabel = $Display/TimerDisp
@onready var time_goal: RichTextLabel = $Display/TimeGoalDisp
@onready var level_name_disp: RichTextLabel = $Display/LevelNameDisp
@onready var clipboard_disp: RichTextLabel = $"Clipboard/Score Calc Disp"

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
	clipboard_disp.visible_ratio = 0.0
	$"Clipboard/Final Score Disp".visible_ratio = 0.0
	$"Clipboard/Rank Disp".visible = false
	
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
	if spawn_text:
		clipboard_disp.visible_ratio += delta/spawn_text_speed_mult
		if spawn_score == false and clipboard_disp.visible_ratio >= 1.0:
			calc_final_score()
	if spawn_score:
		$"Clipboard/Final Score Disp".visible_ratio += delta
		if $"Clipboard/Rank Disp".visible == false and $"Clipboard/Final Score Disp".visible_ratio >= 1.0:
			display_rank()
	
func _on_results(base_score: int):
	fade_out = true
	stop_count = true
	var ped_deduct = GlobVar.kills * 50
	if int(time_elapsed) > goal_times[get_tree().current_scene.name] or goal_times[get_tree().current_scene.name] == INF:
		time_bonus = 0
	final_score = clamp(base_score - ped_deduct + time_bonus, 0, 1000)
	if final_score == 1000 and ped_deduct == 0 and time_bonus == 100:
		rank = 0
	elif final_score >= 900 and base_score >= 900:
		rank = 1
	elif final_score >= 900:
		rank = 2
	elif final_score >= 800:
		rank = 3
	elif final_score >= 700:
		rank = 4
	elif final_score >= 600:
		rank = 5
	else:
		rank = 6
	print(final_score)
	print(rank)
	
	#clipboard
	clip.visible = true
	
	clipboard_disp.text = "[u]Accuracy:[/u]\n" + str(base_score / 10.0) + "%\n" + str(base_score) + " points\n"
	if GlobVar.kills > 0:
		spawn_text_speed_mult += 1
		if GlobVar.kills == 1:
			clipboard_disp.text += "[color=red][u]" + str(GlobVar.kills) + "  Pedestrian Killed[/u]\n" + str(GlobVar.kills * -50) + " points[/color]\n"
		else:
			clipboard_disp.text += "[color=red][u]" + str(GlobVar.kills) + "  Pedestrians Killed[/u]\n" + str(GlobVar.kills * -50) + " points[/color]\n"
	if time_bonus == 100:
		spawn_text_speed_mult += 1
		clipboard_disp.text += "[color=#93C572][u]Time Bonus[/u]\n+100 points[/color]"
	spawn_text = true
	
func calc_final_score():
	$"Clipboard/Final Score Disp".text = "Score: " + str(final_score)+"/1000"
	spawn_score = true

func display_rank():
	$"Clipboard/Rank Disp".visible = true
	$"Clipboard/Rank Disp".frame = rank
	
