extends CharacterBody2D

signal preparemerge

var speed = 200
@onready var target : CharacterBody2D = $"../Player"
@onready var friend = $"../Life0_5_2"
#var hp = 1000
var hp =  500
var attacking = false
var random
var merge = false

func _ready() -> void:
	$RandomAttack.start()

func _on_random_attack_timeout() -> void:
	attack()

func attack() -> void:
	random = randi_range(1,3)
	if random >= 3:
		$AttackArea/CollisionShape2D.disabled = false
		attacking = true
		await get_tree().create_timer(3).timeout
		attacking = false
		$AttackArea/CollisionShape2D.disabled = true
	$RandomAttack.start()
	
func _process(delta: float) -> void:
	if target == null:
		return
	else:
		if !merge:
			if attacking:
				var direction = Vector2((target.global_position.x - position.x), (target.global_position.y - position.y)).normalized()
				velocity += direction * delta * speed
			else:
				var dir = Vector2((target.global_position.x - position.x - 200), (target.global_position.y - position.y) - 150)
				velocity = dir * speed * delta
		else:
			var direction = Vector2(500 - position.x, 250 - position.y)
			velocity = direction * speed * delta
		
		move_and_slide()
	


func _on_hit_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("attackByPlayer"):
		hp -= area.getDamage()
		print(hp)
		if hp <= 0:
			merge = true
			$HitArea/BodyHit.disabled = true
			preparemerge.emit()
		
