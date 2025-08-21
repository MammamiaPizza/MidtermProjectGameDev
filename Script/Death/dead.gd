extends CharacterBody2D

class_name Dead

var Moveset : Array = ["Attack1", "Attack2", "Attack3"]
#var Moveset : Array = ["Attack1"]
@onready var target : CharacterBody2D = get_tree().get_nodes_in_group("player")[0]
var hp = 10000
var randommove

func _ready() -> void:
	$AttackTime.start()
	$AnimatedSprite2D.play("Idle")


func _on_attack_time_timeout() -> void:
	randommove = Moveset.pick_random()
	await get_tree().create_timer(1)
	if randommove == "Attack1":
		position = target.global_position
		$AnimatedSprite2D.play(randommove)
		await get_tree().create_timer(0.6).timeout
		$Hit/Attack1.disabled = false
		await get_tree().create_timer(0.2).timeout
		$Hit/Attack1.disabled = true
		await $AnimatedSprite2D.animation_finished
	
	elif randommove == "Attack2":
		$AnimatedSprite2D.play(randommove)
		await $AnimatedSprite2D.animation_finished
		$Hit/AnimatedSprite2D2.position.x = -4075.0
		$Hit/AnimatedSprite2D2.set_frame_and_progress(0, 0)
		$Hit/AnimatedSprite2D2.flip_h = true
		$Hit/AnimatedSprite2D2.play("Attack2")
		await $Hit/AnimatedSprite2D2.animation_finished
		$Hit/Attack2.disabled = false
		await get_tree().create_timer(0.01).timeout
		$Hit/Attack2.disabled = true
		
	elif randommove == "Attack3":
		$AnimatedSprite2D.play(randommove)
		await $AnimatedSprite2D.animation_finished
		$Hit/AnimatedSprite2D2.position.x = 4075.0
		$Hit/AnimatedSprite2D2.set_frame_and_progress(0, 0)
		$Hit/AnimatedSprite2D2.flip_h = false
		$Hit/AnimatedSprite2D2.play("Attack2")
		await $Hit/AnimatedSprite2D2.animation_finished
		$Hit/Attack2.disabled = false
		await get_tree().create_timer(0.01).timeout
		$Hit/Attack2.disabled = true
	
	$AnimatedSprite2D.play("Idle")
