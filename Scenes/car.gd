extends CharacterBody2D


@export var max_speed = 200
@export var rotation_speed = 2.5
@export var acceleration = 600
@export var friction = 500

var rotation_direction = 0
var oil_line = Line2D

func _ready(): 
	oil_line = Line2D.new()
	oil_line.width = 6
	oil_line.default_color = Color.BLACK
	oil_line.antialiased = true
	get_parent().add_child.call_deferred(oil_line)

func get_input():
	rotation_direction = Input.get_axis("turn_left", "turn_right")
	var move_input = Input.get_axis("forward", "backward")
	if move_input != 0:
		var direction = transform.y.normalized()
		velocity += direction * move_input * acceleration * get_physics_process_delta_time()
		if velocity.length() > max_speed:
			velocity = velocity.normalized() * max_speed
	else: 
		var speed = velocity.length()
		speed -= friction * get_physics_process_delta_time()
		speed = max(speed, 0)
		velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	rotation += rotation_direction * rotation_speed * delta
	move_and_slide()
	if Input.is_action_pressed("oil"):
		oil_line.add_point(global_position)
