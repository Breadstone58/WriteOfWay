extends CharacterBody2D


@export var speed = 100     #how fast the character will move (pixels per sec)
@export var rotation_speed = 1.5

var rotation_direction = 0


func get_input():
	rotation_direction = Input.get_axis("turn_left", "turn_right")
	velocity = transform.y * Input.get_axis("forward", "backward") * speed

func _physics_process(delta):
	get_input()
	rotation += rotation_direction * rotation_speed * delta * -1 * Input.get_axis("forward", "backward")
	move_and_slide()
