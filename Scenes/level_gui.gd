extends Node2D

var goal_times = {
	"level_0": INF,
	"level_1": 2,
	"level_2": 20,
	"level_3": 30,
	"level_4": 30,
	"level_5": 25,
	"level_6": 30,
	"level_7": 35,
	"level_8": 10,
	"level_9": 50,
	"level_10": 60,
	"level_11": 50,
	"level_12": 0,
	"level_13": 0,
	"level_14": 0,
	"level_15": 0,
	"level_16": 0,
	"level_17": 0,
	"level_18": 0,
	"level_19": 0,
	"level_20": 0,
}

var level_name = {
	"level_0": "Mona Lisa",
	"level_1": "Level 1: Yield to Pedestrians",
	"level_2": "Don't Be a Square",
	"level_3": "Round and Round We Go",
	"level_4": "Write Angles",
	"level_5": "",
	"level_6": "The Perfect Angle",
	"level_7": "The Pentagon",
	"level_8": "Jaywalkers",
	"level_9": "",
	"level_10": "",
	"level_11": "",
	"level_12": "",
	"level_13": "",
	"level_14": "",
	"level_15": "",
	"level_16": "",
	"level_17": "",
	"level_18": "",
	"level_19": "",
	"level_20": "",
}


var title_size = {
	"level_0": 73,
	"level_1": 57,
	"level_2": 50,
	"level_3": 50,
	"level_4": 50,
	"level_5": 50,
	"level_6": 50,
	"level_7": 50,
	"level_8": 50,
	"level_9": 50,
	"level_10": 50,
	"level_11": 50,
	"level_12": 0,
	"level_13": 0,
	"level_14": 0,
	"level_15": 0,
	"level_16": 0,
	"level_17": 0,
	"level_18": 0,
	"level_19": 0,
	"level_20": 0,
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


@export var rank_audio: Array[AudioStream] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobVar.results = false
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
	level_name_disp.add_theme_font_size_override("normal_font_size", title_size[get_tree().current_scene.name])
	
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
	if Input.is_key_pressed(KEY_E):
		get_tree().change_scene_to_file("res://Scenes/Levels/Level Select.tscn")
	GlobVar.rank_displayed = $"Clipboard/Rank Disp".visible
	
func _on_results(base_score: int):
	GlobVar.results = true
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
	elif final_score >= 850:
		rank = 2
	elif final_score >= 800:
		rank = 3
	elif final_score >= 600:
		rank = 4
	elif final_score >= 500:
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
	GlobVar.rank = rank
	$"Clipboard/Rank Disp".frame = rank
	$RankAudio.stream = rank_audio[rank]
	$RankAudio.play()
	
