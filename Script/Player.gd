extends CharacterBody2D

signal gethit

var hp = 100
var stamina = 1000000
var damage = 20

var speed = 200
var gravity = 3

var doublejump = true
var alive = true


func _ready() -> void:
	$regenStamina.start()
	$Attack.hide()
	#$Attack/CollisionShape2D.disabled = true

func _process(delta: float) -> void:
	if alive:
		var axis = Input.get_axis("left", "right")
		velocity = Vector2(axis * speed, velocity.y)
		
		if !is_on_floor():
			velocity.y += gravity
		elif is_on_floor():
			doublejump = true

		if Input.is_action_pressed("iframedodge"):	
			dodge()
		
		if Input.is_action_just_pressed("jump"):
			jumping()
		
		if Input.is_action_pressed("down") and is_on_floor():	
			position.y += 1
		
		if (axis > 0):
			$Sprite2D.flip_h = false
			#$Attack/AnimatedSprite2D.flip_h = false
			#$Attack/CollisionShape2D.scale.x *= 1
			$Attack.scale.x = 1
		elif (axis < 0):
			$Sprite2D.flip_h = true
			#$Attack/AnimatedSprite2D.flip_h = true
			#$Attack/CollisionShape2D.scale.x *= -1
			$Attack.scale.x = -1
		
		if Input.is_action_just_pressed("AttackMelee"):
			attack()
			speed = 200
			
		move_and_slide()
	
	if hp <= 0:
		alive = false
		#queue_free()
		hide()
	
func dodge():
	$Attack/AnimatedSprite2D.set_frame(0)
	$Attack/CollisionShape2D.disabled = true
	$Attack.hide()
	if stamina > 20:
			$Hitbox/CollisionShape2D.disabled = true
			stamina = stamina - 20
			speed = 400
			await get_tree().create_timer(0.3).timeout
			#await get_tree().create_timer(5).timeout
			speed = 200
			$Hitbox/CollisionShape2D.disabled = false

func _on_regen_stamina_timeout() -> void:
	if stamina<100:
		stamina += 1

func attack():
	$Attack/CollisionShape2D.disabled = false
	$Attack.show()
	$Attack/AnimatedSprite2D.play("default")
	await $Attack/AnimatedSprite2D.animation_finished
	$Attack/CollisionShape2D.disabled = true
	$Attack.hide()

func jumping():
	if !is_on_floor() and doublejump:
		velocity.y -= 200
		doublejump = false
	elif is_on_floor():
		velocity.y -= 200
	


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("attackByBoss"):
		var getdamagefromattack = area.getDamage()
		hp -= getdamagefromattack
		print("Hello")
		
