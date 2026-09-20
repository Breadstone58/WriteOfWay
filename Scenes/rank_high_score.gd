extends AnimatedSprite2D

@export var level: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GlobVar.high_scores[level-1] in range(7):
		visible = true
		frame = GlobVar.high_scores[level-1]
	else:
		visible = false
