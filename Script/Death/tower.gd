extends StaticBody2D

signal Turnon

var hp : int = 7
var turnon= false

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("attackByPlayer"):
		hp -= 1
		if hp <= 0:
			$Area2D/CollisionShape2D.disabled = true
			$Area2D.queue_free()
			turnon = true
			turnonTower()

func turnonTower():
	turnon.emit()
