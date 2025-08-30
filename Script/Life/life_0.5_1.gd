extends CharacterBody2D

var speed = 100
@onready var target : CharacterBody2D = get_tree().get_nodes_in_group("player")[0]
var hp = 1000

#func _ready() -> void:
	#$RandomAttack.start()
#
#func _on_random_attack_timeout() -> void:
	#attack()
#
#
#func attack() -> void:
	#$AttackArea/CollisionShape2D.disabled = false
	#velocity = target.velocity * speed
	#move_and_slide()

func _process(delta: float) -> void:
	velocity = Vector2(target.global_position)
	move_and_slide()
	print(velocity)
