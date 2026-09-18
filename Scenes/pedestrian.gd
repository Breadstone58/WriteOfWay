extends Area2D

@onready var anim: AnimatedSprite2D = $Anim

func _ready() -> void:
	anim.animation = "walk"
	anim.play()

func _process(_delta: float) -> void:
	pass

func _on_body_shape_entered(_body_rid: RID, _body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if visible == true:
		print("killed a guy")
		$AudioStreamPlayer2D.play()
		visible = false
		await $AudioStreamPlayer2D.finished
		queue_free()
