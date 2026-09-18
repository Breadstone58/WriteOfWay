extends Area2D



func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	print("killed a guy")
	$AudioStreamPlayer2D.play()
	visible = false
	await $AudioStreamPlayer2D.finished
	queue_free()
