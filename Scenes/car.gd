extends CharacterBody2D


@export var max_speed = 300
@export var rotation_speed = 2
@export var acceleration = 300
@export var friction = 1000

var rotation_direction = 0
var oil_line = Line2D

var drawing_active = true

func _ready():
	set_collision_layer_value(2,true)
	oil_line = Line2D.new()
	oil_line.width = 12
	oil_line.default_color = Color.BLACK
	oil_line.antialiased = true
	oil_line.z_index = 3
	oil_line.z_as_relative = false
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
	if drawing_active:
		get_input()
		if Input.is_action_just_pressed("oil") and get_tree().current_scene.name != "level select":
			drawing_active = false
			visible = false
			set_collision_layer_value(2, false)
			var point_array: PackedVector2Array = oil_line.points.duplicate()
			for i in range(point_array.size()):
				var pt: Vector2 = point_array[i]
				pt.x -= 648.0
				point_array[i] = pt
			SignalBus.export_line.emit(point_array)
		if Input.is_action_pressed("backward"):
			rotation += rotation_direction * rotation_speed * delta * -1
		else:
			rotation += rotation_direction * rotation_speed * delta
		move_and_slide()
		if drawing_active:
			oil_line.add_point($Marker2D.global_position)
		if Input.is_action_pressed("increase_speed"):
			max_speed = 500
			acceleration = 600
		else:
			max_speed = 300
			acceleration = 300
		if Input.is_action_just_pressed("reset"):
			get_tree().reload_current_scene()
	if Input.is_action_just_pressed("menu"):
		get_tree().change_scene_to_file("res://Scenes/Levels/Level Select.tscn")
		
