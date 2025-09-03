extends CharacterBody2D

var speed = 200
@onready var target : CharacterBody2D = get_tree().get_nodes_in_group("player")[0]
var hp = 10000
var attacking = false
var random
var exhp
var randommove = 1
var timemark = -1
var phasetwo = false
func _ready() -> void:
	$AnimatedSprite2D.play("idle")
func _process(delta: float) -> void:
	$Label.set_text(str(int(($ResetWorld.get_time_left()))))

	if randommove == 1:
		var dir = Vector2((620 -position.x),(88-position.y)).normalized()
		velocity = dir * speed * delta
		
	elif  randommove == 2:
		var dir = Vector2((66 -position.x),(474-position.y)).normalized()
		velocity = dir * speed
		
	else:
		var dir = Vector2((1200 -position.x),(500-position.y)).normalized()
		velocity = dir * speed
	
	move_and_slide()
	
func _on_timermove_timeout() -> void:
	randommove = randi_range(1, 3)
	
		
func _on_random_attack_timeout() -> void:
	timemark *= -1
	if timemark > 0:
		$"../Sprite2D".set_modulate("db54cb")
		exhp = hp
		$"../Area2D".position = position
	else:
		$"../Sprite2D".set_modulate("ffffff")
		hp = exhp
		$"../Area2D".position.x = -9000



func _on_hit_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("attackByPlayer"):
		hp -= area.getDamage()
		print(hp)
	if hp <= 0 :
		if !phasetwo:
			phasetwo = true
			$ResetWorld.start()
			$Label.visible = true
			#hp = 10000
			hp = 10000
			$"../AudioStreamPlayer2D".stop()
			$"../AudioStreamPlayer2D2".play()
		else:
			$"../UI/Interface/CanvasLayer".hide()
			$"../Player/Camera2D2".enabled = false
			$"../Player/Camera2D".enabled = false
			Bossclean.bosswin()
			Bossclean.time = true
			var loading_scene = preload("res://Scene/load/LoadingScreen.tscn").instantiate()
			loading_scene.target_scene = "res://Scene/UI/select-door.tscn"
			get_tree().current_scene.add_child(loading_scene)


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("attackByPlayer"):
		exhp -= area.getDamage()
		print(exhp)


func _on_reset_world_timeout() -> void:
	phasetwo = false
	hp = 10000
	$Label.visible = false
	$"../AudioStreamPlayer2D".play()
	$"../AudioStreamPlayer2D2".stop()
