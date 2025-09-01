extends CharacterBody2D

signal gethit

var shadow = preload("res://Scene/Player/Shadow.tscn")

var hp = 100
var stamina = 100

var speed = 200
var gravity = 3
var jumpforce = 350

var doublejump = true
var alive = true
var checkdash = false

var i : int

func _ready() -> void:
	$regenStamina.start()
	$AnimatedSprite2D/Attack.hide()

#controlling part control
func _process(delta: float) -> void:
	#if alive it going to do
	if alive:
		#get axis left or right then set position
		var axis = Input.get_axis("left", "right")
		velocity = Vector2(axis * speed, velocity.y)
		
		#check condition to play animation if on air can jump or fall
		if velocity == Vector2.ZERO:
			$AnimatedSprite2D.play("Idle")
		elif velocity.y > 0:
			$AnimatedSprite2D.play("Fall")
		elif velocity.y < 0:
			$AnimatedSprite2D.play("jump")
		elif axis != 0:
			$AnimatedSprite2D.play("Walking")
		
		#check is it floor if not gravity pull to ground and if yes recharge doublejump
		if !is_on_floor():
			velocity.y += gravity
		elif is_on_floor():
			doublejump = true

		if Input.is_action_just_pressed("iframedodge"):
			dodge()
		
		if Input.is_action_just_pressed("jump"):
			jumping()
			$AnimatedSprite2D.play("jump")
		
		if Input.is_action_pressed("down") and is_on_floor():	
			position.y += 1
		
		if (axis > 0):
			$AnimatedSprite2D.scale.x = 0.5
			
		elif (axis < 0):
			$AnimatedSprite2D.scale.x = -0.5
		
		if Input.is_action_just_pressed("AttackMelee"):
			attack()
			speed = 200
			
		move_and_slide()
	
	#check dead
	if hp <= 0:
		alive = false
		#queue_free()
		hide()
	
func dodge():
	#before start should make all component ready to open
	$AnimatedSprite2D/Attack/AnimatedSprite2D.set_frame(0)
	$AnimatedSprite2D/Attack/CollisionShape2D.disabled = true
	$AnimatedSprite2D/Attack.hide()
	#checkdash link to createTrail in Process
	if stamina > 20:
			$Hitbox/CollisionShape2D.disabled = true
			#checkdash = true
			stamina = stamina - 20
			speed = 400
			$ShadowTrail.start()
			await get_tree().create_timer(0.3).timeout
			#checkdash = false
			speed = 200
			$Hitbox/CollisionShape2D.disabled = false
			$ShadowTrail.stop()

#create Shadow follow after dash
func createTrail() -> void:
	var trail = shadow.instantiate()
	trail.position = global_position
	trail.scale = $AnimatedSprite2D.global_scale
	get_tree().current_scene.add_child(trail)
	

func _on_regen_stamina_timeout() -> void:
	if stamina<100:
		stamina += 1

func attack():
	$AnimatedSprite2D/Attack/CollisionShape2D.disabled = false
	$AnimatedSprite2D/Attack.show()
	$AnimatedSprite2D/Attack/AnimatedSprite2D.play("default")
	await $AnimatedSprite2D/Attack/AnimatedSprite2D.animation_finished
	$AnimatedSprite2D/Attack/CollisionShape2D.disabled = true
	$AnimatedSprite2D/Attack.hide()

func jumping():
	if !is_on_floor() and doublejump:
		velocity.y = 0
		velocity.y -= jumpforce
		doublejump = false
	elif is_on_floor():
		velocity.y = 0
		velocity.y -= jumpforce
	
func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("attackByBoss"):
		var getdamagefromattack = area.getDamage()
		hp -= getdamagefromattack
		gethit.emit()


func _on_shadow_trail_timeout() -> void:
	createTrail()


func _on_node_2d_tower_power_on() -> void:
	$CollisionShape2D.disabled = true
