extends CharacterBody2D

signal gethit

var shadow = preload("res://Scene/shadow.tscn")

var hp = 100
var stamina = 100

var speed = 200
var gravity = 3

var doublejump = true
var alive = true
var checkdash = false

var i : int

func _ready() -> void:
	$regenStamina.start()
	$Attack.hide()

#controlling part control
func _process(delta: float) -> void:
	#if alive it going to do
	if alive:
		#get axis left or right then set position
		var axis = Input.get_axis("left", "right")
		velocity = Vector2(axis * speed, velocity.y)
		
		#check is it floor if not gravity pull to ground and if yes recharge doublejump
		if !is_on_floor():
			velocity.y += gravity
		elif is_on_floor():
			doublejump = true

		if Input.is_action_just_pressed("iframedodge"):
			dodge()
			
		#make Shadow after dash is on (Make A lot)
		#if checkdash:
			#createTrail()
		
		if Input.is_action_just_pressed("jump"):
			jumping()
		
		if Input.is_action_pressed("down") and is_on_floor():	
			position.y += 1
		
		if (axis > 0):
			$Sprite2D.flip_h = false
			$Attack.scale.x = 1
		elif (axis < 0):
			$Sprite2D.flip_h = true
			$Attack.scale.x = -1
		
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
	$Attack/AnimatedSprite2D.set_frame(0)
	$Attack/CollisionShape2D.disabled = true
	$Attack.hide()
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
	trail.position = position
	trail.scale = scale
	get_tree().current_scene.add_child(trail)
	

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
		velocity.y -= 250
		doublejump = false
	elif is_on_floor():
		velocity.y -= 250
	
func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("attackByBoss"):
		var getdamagefromattack = area.getDamage()
		hp -= getdamagefromattack


func _on_shadow_trail_timeout() -> void:
	createTrail()
