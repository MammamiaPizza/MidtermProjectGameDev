extends CharacterBody2D

class_name dimension

signal changePhase

var Moveset : Array = ["Attack1", "Attack2"]
#var Moveset : Array = ["Attack1"]
@onready var target : CharacterBody2D = get_tree().get_nodes_in_group("player")[0]
var hp = 10000
var randommove
var cooldown = 3.5
#var checkrandom = true
var phasetwo = false
var gravityset = 0
func _ready() -> void:
	$AttackTime.start()
	$body.play("Idle")


func _on_attack_time_timeout() -> void:
	if hp > 0 :
		print("pass")
		randommove = Moveset.pick_random()
		if gravityset != 0 :
			gravityset = randi_range(1,4)
			target.gravity_set = gravityset
			$"..".rotateevery(gravityset)
		#print(target.position.x)
		#print(position.x)

		if randommove == "Attack1":
			$Hit.setDamage(30)
			$body.play("warp")
			await $body.animation_finished
			position = target.global_position
			$body.play_backwards("warp")
			await $body.animation_finished
			$body.play("Attack1")
			$HitArea/CollisionShape2D.disabled = false
			$Hit/Attack1ef.play("Attack")
			await get_tree().create_timer(0.15).timeout
			$Hit/Attack1.disabled = false
			await $Hit/Attack1ef.animation_finished
			$Hit/Attack1.disabled = true
			await $body.animation_finished
			$HitArea/CollisionShape2D.disabled = true
			
		elif randommove == "Attack2":
			$Hit.setDamage(50)
			if (position.x > target.position.x):
				$body.play("warp")
				await $body.animation_finished
				position.x = target.global_position.x+100
				position.y = target.global_position.y
				$body.play_backwards("warp")
				await $body.animation_finished
				$body.scale.x *= -1
				$body.play("Attack2")
				$HitArea/CollisionShape2D.disabled = false
				await $body.animation_finished
				$Hit/Attack2ef.set_frame_and_progress(0, 0)
				$Hit/Attack2ef.play("Attack")
				$Hit/Attack2ef.show()
				await $Hit/Attack2ef.animation_finished
				$Hit/Attack2.disabled = false
				await get_tree().create_timer(0.05).timeout
				$body.scale.x *= -1
				$Hit/Attack2.disabled = true
				$Hit/Attack2ef.hide()
				$HitArea/CollisionShape2D.disabled = true
				
			elif (position.x < target.position.x):
				$body.play("warp")
				await $body.animation_finished
				position.x = target.global_position.x-100
				position.y = target.global_position.y
				$body.play_backwards("warp")
				await $body.animation_finished
				$body.play("Attack2")
				$HitArea/CollisionShape2D.disabled = false
				await $body.animation_finished
				$Hit/Attack3ef.set_frame_and_progress(0, 0)
				$Hit/Attack3ef.play("Attack3")
				$Hit/Attack3ef.show()
				
				await $Hit/Attack3ef.animation_finished
				$Hit/Attack3.disabled = false
				await get_tree().create_timer(0.05).timeout
				$Hit/Attack3.disabled = true
				$Hit/Attack3ef.hide()
				$HitArea/CollisionShape2D.disabled = true
				
		elif randommove == "Attack4":
			$Hit.setDamage(100)
			position = target.global_position
			$body.play("Attack4")
			$HitArea/CollisionShape2D.disabled = false
			$Hit/Attack4ef.play("Attack")
			$Hit/Attack4ef.show()
			await get_tree().create_timer(0.6).timeout
			await $body.animation_finished
			$Hit/Attack4.disabled = false
			await get_tree().create_timer(0.2).timeout
			$Hit/Attack4.disabled = true
			await $body.animation_finished
			$Hit/Attack4ef.hide()
			$HitArea/CollisionShape2D.disabled = true
				
		$body.play("Idle")
		$CooldownMove.start()
		
	else:
		return
	

func _on_hit_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("attackByPlayer"):
		hp -= area.damage
		if hp <= 0:
			#print("before change phasetwo value")
			$HitArea/CollisionShape2D.disabled = true
			if phasetwo == false:
				
				phasetwo = true
				$"../UI".set_visible(false)
				#print("after change phasetwo value")
				$"../VideoStreamPlayer".visible = true
				$"../Camera2D".set_enabled(true)
				$"../Player"/Camera2D.set_enabled(false)
				$"../VideoStreamPlayer".play()
				await $"../VideoStreamPlayer".finished
				$"../Camera2D".set_enabled(false)
				$"../Player/Camera2D".set_enabled(true)				
				$"../TileMapLayer2".set_enabled(false)
				$"../TileMapLayer3".set_enabled(true)
				gravityset = 2
				$"../TileMapLayer".set_enabled(false)
				$"../Sprite2D".hide()
				target.gravity = 1
				$"../VideoStreamPlayer".visible = false
				hp = 10000
				$"../UI".set_visible(true)
				Moveset.append("Attack4")
				
				$AttackTime.start()
				
			else:
				$"../UI/Interface/CanvasLayer".hide()
				$"../Player/Camera2D".enabled = false
				Bossclean.bosswin()
				Bossclean.dimension = true
				var loading_scene = preload("res://Scene/load/LoadingScreen.tscn").instantiate()
				loading_scene.target_scene = "res://Scene/UI/select-door.tscn"
				get_tree().current_scene.add_child(loading_scene)

func _on_cooldown_move_timeout() -> void:
	$AttackTime.start()
