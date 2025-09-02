extends CharacterBody2D

class_name dimension

signal changePhase

var Moveset : Array = ["Attack1", "Attack2"]
#var Moveset : Array = ["Attack1"]
@onready var target : CharacterBody2D = get_tree().get_nodes_in_group("player")[0]
var hp = 10
var randommove
var cooldown = 3.5
#var checkrandom = true
var sealcheck = false
var phasetwo = false
var gravityset = 0
func _ready() -> void:
	$AttackTime.start()
	$body.play("Idle")


func _on_attack_time_timeout() -> void:
	if hp > 0 :
		randommove = Moveset.pick_random()
		if gravityset != 0 :
			gravityset = randi_range(1,4)
			target.gravity_set = gravityset
			$".".rotateevery(gravityset)
		#print(target.position.x)
		#print(position.x)
		if !sealcheck:
			if randommove == "Attack1":
				$body.play("warp")
				await $body.animation_finished
				position = target.global_position
				$body.play_backwards("warp")
				await $body.animation_finished
				$body.play(randommove)
				await get_tree().create_timer(0.6).timeout
				$Hit/Attack1.disabled = false
				await get_tree().create_timer(0.2).timeout
				$Hit/Attack1.disabled = true
				await $body.animation_finished
			
			elif randommove == "Attack2":
				if (position.x > target.position.x):
					$body.play("warp")
					await $body.animation_finished
					position.x = target.global_position.x+100
					position.y = target.global_position.y
					$body.play_backwards("warp")
					await $body.animation_finished
					$body.scale *= -1
					$body.play("Attack2")
					await $body.animation_finished
					$body.scale *= -1
					$Hit/AnimatedSprite2D.set_frame_and_progress(0, 0)
					$Hit/AnimatedSprite2D.play("Attack2")
					$Hit/AnimatedSprite2D.show()
					
					await $Hit/AnimatedSprite2D2.animation_finished
					$Hit/Attack2.disabled = false
					await get_tree().create_timer(0.05).timeout
					$Hit/Attack2.disabled = true
					
				elif (position.x < target.position.x):
					$body.play("warp")
					await $body.animation_finished
					position.x = target.global_position.x-100
					position.y = target.global_position.y
					$body.play_backwards("warp")
					await $body.animation_finished
					$body.play("Attack2")
					await $body.animation_finished
					$Hit/AnimatedSprite2D3.set_frame_and_progress(0, 0)
					$Hit/AnimatedSprite2D3.play("Attack3")
					$Hit/AnimatedSprite2D3.show()
					
					await $Hit/AnimatedSprite2D2.animation_finished
					$Hit/Attack3.disabled = false
					await get_tree().create_timer(0.05).timeout
					$Hit/Attack3.disabled = true
				
			elif randommove == "Attack4":
				position = target.global_position
				$body.play(randommove)
				await get_tree().create_timer(0.6).timeout
				$Hit/Attack4.disabled = false
				await get_tree().create_timer(0.2).timeout
				$Hit/Attack4.disabled = true
				await $body.animation_finished
			
			$body.play("Idle")
			$Hit/AnimatedSprite2D2.hide()
			$CooldownMove.start()
		else:
			return
	

func _on_hit_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("attackByPlayer"):
		hp -= area.damage
		if hp < 0:
			if phasetwo == false:
				phasetwo = true
				$"../UI/VideoStreamPlayer".visible = true
				$"../Camera2D".set_enabled(true)
				$"../Player"/Camera2D.set_enabled(false)

				$"../UI/VideoStreamPlayer".play()
				await $"../UI/VideoStreamPlayer".finished
				$"../Camera2D".set_enabled(false)
				$"../Player"/Camera2D.set_enabled(true)				
				$"../TileMapLayer2".set_enabled(false)
				$"../TileMapLayer3".set_enabled(true)
				gravityset = 2
				hp = 10000
				$"../TileMapLayer".set_enabled(false)
				$"../Sprite2D".hide()
				target.gravity = 1
				$"../UI/VideoStreamPlayer".visible = false
			else:
				return
func _on_cooldown_move_timeout() -> void:
	$AttackTime.start()




func _process(delta: float) -> void:
	if sealcheck:
		var direction = Vector2(625,300) - global_position
		velocity = direction.normalized() * 20 
		$Body.disabled = true
		move_and_slide()
		
