extends CharacterBody2D

var speed = 200
var gravity = 3
var stamina = 100

func _ready() -> void:
	$regenStamina.start()

func _process(delta: float) -> void:
	
	var axis = Input.get_axis("left", "right")
	velocity = Vector2(axis * speed, velocity.y)
	
	if !is_on_floor():
		velocity.y += gravity

	if Input.is_action_just_pressed("iframedodge"):	
		dodge()
	
	if Input.is_action_just_pressed("jump"):
		velocity.y -= 200
	
	if Input.is_action_just_pressed("down"):	
		position.y += 1
	
	if (velocity.x > 1):
		$Sprite2D.flip_h = false
	elif (velocity.x < -1):
		$Sprite2D.flip_h = true
	
	if Input.is_action_just_pressed("AttackMelee"):
		attack()
	
	
	move_and_slide()
	
func dodge():
	if stamina > 20:
			stamina = stamina - 20
			speed = 800
			await get_tree().create_timer(0.1).timeout
			speed = 200

func _on_regen_stamina_timeout() -> void:
	if stamina<100:
		stamina += 1

func attack():
	
