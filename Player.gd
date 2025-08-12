extends CharacterBody2D

var speed = 200
var gravity = 3

func _process(delta: float) -> void:

	var axis = Input.get_axis("left", "right")
	velocity = Vector2(axis * speed, velocity.y)
	move_and_slide()
	
	if !is_on_floor():
		velocity.y += gravity
	
	if Input.is_action_just_pressed("jump"):
		velocity.y -= 150
	
	if Input.is_action_just_pressed("down"):	
		position.y += 1
	
