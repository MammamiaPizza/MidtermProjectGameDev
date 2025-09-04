extends Area2D

var randomDamage : Array = [90, -90]
var damage :int

func getDamage() -> int:
	damage = randomDamage.pick_random()
	return damage
	
func setDamage(inputvalue: int) -> void:
	randomDamage.append(inputvalue)
