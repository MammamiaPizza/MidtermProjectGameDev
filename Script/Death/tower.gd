extends StaticBody2D

signal TowerIsOpen

var hp : int = 7

var target : Vector2

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("attackByPlayer"):
		#print("attackTower")
		hp -= 1
		if hp <= 0:
			$Area2D/CollisionShape2D.disabled = true
			$Area2D.queue_free()


func _process(delta: float) -> void:
	if target != null:
		var direction1 = target - position
		position += direction1 * delta
	
func setTarget(targetposition : Vector2) -> void:
	target = targetposition
	
