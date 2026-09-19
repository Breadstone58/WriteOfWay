extends Area2D

@onready var anim: AnimatedSprite2D = $Anim
var alive = true

func _ready() -> void:
	anim.animation = "walk"
	anim.play()

func _process(_delta: float) -> void:
	pass

func _on_body_shape_entered(_body_rid: RID, _body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if alive == true:
		alive = false
		print("killed a guy")
		anim.animation = "death"
		anim.play()
		anim.scale = Vector2(2,2)
		$AnimationPlayer.speed_scale = 0
		$AudioStreamPlayer2D.play()
