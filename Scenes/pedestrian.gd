extends Area2D

@onready var anim: AnimatedSprite2D = $Anim
var alive = true
@export var jaywalker: bool = false

func _ready() -> void:
	if jaywalker:
		anim.animation = "walk_blue"
	else:
		anim.animation = "walk"
	anim.play()
	z_index = 5
	SignalBus.reset_kills.emit()

func _process(_delta: float) -> void:
	pass

func _on_body_shape_entered(_body_rid: RID, _body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if alive == true:
		alive = false
		print("killed a guy")
		SignalBus.person_killed.emit()
		if jaywalker:
			anim.animation = "death_blue"
		else:
			anim.animation = "death"
			anim.scale = Vector2(2,2)
		anim.play()
		z_index = 2
		
		$AnimationPlayer.speed_scale = 0
		$AudioStreamPlayer2D.play()
