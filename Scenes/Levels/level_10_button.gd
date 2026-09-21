extends Area2D

func _ready() -> void:
	pass
	
func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_E) and get_overlapping_bodies().size() > 0:
		SceneTransition.change_scene("res://Scenes/Levels/level_10.tscn")
	
func _on_body_shape_entered(_body_rid: RID, _body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if visible == true:
		print("test")
		
