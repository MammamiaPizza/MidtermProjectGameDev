extends CharacterBody2D

#var Moveset : Array = ["Attack1", "Attack2", "Attack3"]
var Moveset: Array = ["Attack1"]
@onready var target : CharacterBody2D
var speed = 300
var randommove

func _ready() -> void:
	$AttackTime.start()
	$AnimatedSprite2D.play("Idle")


func _on_attack_time_timeout() -> void:
	randommove = Moveset.pick_random()
	if randommove == "Attack1":
		target = get_tree().get_nodes_in_group("player")[0]
		position = target.global_position
		$AnimatedSprite2D.play(randommove)
		await get_tree().create_timer(0.6).timeout
		$Hit/Attack1.disabled = false
		await get_tree().create_timer(0.85).timeout
		$Hit/Attack1.disabled = true
	
		
