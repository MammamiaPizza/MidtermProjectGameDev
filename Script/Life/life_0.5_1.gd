extends CharacterBody2D

var speed = 200
@onready var target : CharacterBody2D = get_tree().get_nodes_in_group("player")[0]
var hp = 1000
var attacking = false
var random

func _ready() -> void:
	$RandomAttack.start()

func _on_random_attack_timeout() -> void:
	attack()

func attack() -> void:
	random = randi_range(1,3)
	print(random)
	if random >= 3:
		$AttackArea/CollisionShape2D.disabled = false
		attacking = true
		await get_tree().create_timer(1.5).timeout
		attacking = false
		$AttackArea/CollisionShape2D.disabled = true
	$RandomAttack.start()
	
func _process(delta: float) -> void:
	if target == null:
		return
	else:
		if attacking:
			var direction = Vector2((target.global_position.x - position.x), (target.global_position.y - position.y)).normalized()
			velocity += direction * delta * speed
		else:
			var dir = Vector2((target.global_position.x - position.x - 75), (target.global_position.y - position.y) - 75)
			velocity = dir * speed * delta
		
		move_and_slide()
	


func _on_hit_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("attackByPlayer"):
		hp -= area.getDamage()
		#print(hp)
