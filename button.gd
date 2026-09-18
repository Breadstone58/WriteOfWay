extends Area2D

func _ready() -> void:
	pass
	
func _process(_delta: float) -> void:
	pass
	
func _on_body_shape_entered(_body_rid: RID, _body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if visible == true:
		print("test")
		if Input.is_key_pressed(KEY_E):
				get_tree().change_scene_to_file("res://Scenes/Levels/level_0.tscn")
