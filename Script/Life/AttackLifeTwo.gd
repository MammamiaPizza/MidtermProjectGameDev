extends Area2D

var damage = -50

func getDamage() -> int:
	return damage
	
func setDamage(inputvalue: int) -> void:
	damage = inputvalue
