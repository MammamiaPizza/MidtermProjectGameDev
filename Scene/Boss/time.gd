extends CharacterBody2D

var speed = 200
@onready var target : CharacterBody2D = get_tree().get_nodes_in_group("player")[0]
var hp = 10000
var attacking = false
var random
var exhp
var randommove = 1
var timemark = -1
func _ready() -> void:
	pass

func _on_timermove_timeout() -> void:
	randommove.randi(1,3)
	if randommove == 1:
		var dir = Vector2((620 -position.x),(88-position.y)).normalized()
		velocity = dir * speed
		move_and_slide()
	elif  randommove == 2:
		var dir = Vector2((66 -position.x),(474-position.y)).normalized()
		velocity = dir * speed
		move_and_slide()
	else:
		var dir = Vector2((1168 -position.x),(527-position.y)).normalized()
		velocity = dir * speed
		move_and_slide()
		
func _on_random_attack_timeout() -> void:
	timemark *= -1
	if timemark > 0:
		$"../Sprite2D".set_modulate("db54cb")
		exhp = hp
		$"../Area2D".position = position
	else:
		$"../Sprite2D".set_modulate("ffffff")
		hp = exhp
		$"../Area2D".position.x = -9000



func _on_hit_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("attackByPlayer"):
		hp -= area.getDamage()
		print(hp)


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("attackByPlayer"):
		exhp -= area.getDamage()
		print(exhp)
