extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_frames.set_animation_loop("boost", true)
	sprite_frames.set_animation_loop("idle", false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
var current_anim: String = ""
func _process(_delta: float) -> void:
	if GlobVar.results == false:
		var t_animation = ""
		if Input.is_action_pressed("increase_speed"):
			t_animation = "boost"
		else:
			pass # i dont fucking know bro
		if current_anim != t_animation:
			current_anim = t_animation
			play(t_animation)
			if t_animation == "boost":
				play(t_animation)
				$AudioStreamPlayer2D.play()
				$AnimationPlayer.play('Boost')
			else:
				$AnimationPlayer.play("BoostOFF")
				await $AnimationPlayer.animation_finished
				stop()
			
		
