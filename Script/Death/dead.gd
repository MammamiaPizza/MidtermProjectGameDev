extends CharacterBody2D

class_name Dead

var Moveset : Array = ["Attack1", "AttackWhole"]
#var Moveset : Array = ["Attack1"]
@onready var target : CharacterBody2D = get_tree().get_nodes_in_group("player")[0]
var hp = 10000
var randommove
var cooldown = 2

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
	
	elif randommove == "AttackWhole":
		if (position.x > target.position.x):
			$AnimatedSprite2D.play("Attack2")
			await $AnimatedSprite2D.animation_finished
			$Hit/AnimatedSprite2D2.position.x = -4075.0
			$Hit/AnimatedSprite2D2.set_frame_and_progress(0, 0)
			$Hit/AnimatedSprite2D2.flip_h = true
			$Hit/AnimatedSprite2D2.play("Attack2")
			await $Hit/AnimatedSprite2D2.animation_finished
			$Hit/Attack2.disabled = false
			await get_tree().create_timer(0.01).timeout
			$Hit/Attack2.disabled = true	
		elif (position.x < target.position.x):
			$AnimatedSprite2D.play("Attack3")
			await $AnimatedSprite2D.animation_finished
			$Hit/AnimatedSprite2D2.position.x = -4075.0
			$Hit/AnimatedSprite2D2.set_frame_and_progress(0, 0)
			$Hit/AnimatedSprite2D2.flip_h = true
			$Hit/AnimatedSprite2D2.play("Attack2")
			await $Hit/AnimatedSprite2D2.animation_finished
			$Hit/Attack3.disabled = false
			await get_tree().create_timer(0.01).timeout
			$Hit/Attack3.disabled = true
	
	$AnimatedSprite2D.play("Idle")
	await get_tree().create_timer(cooldown)
