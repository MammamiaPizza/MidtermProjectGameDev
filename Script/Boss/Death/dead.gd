extends CharacterBody2D

class_name Dead

signal changePhase

#var Moveset : Array = ["Attack1", "AttackWhole"]
var Moveset : Array = ["AttackWhole"]
@onready var target : CharacterBody2D = $"../Player"
var hp = 1000
var randommove
var cooldown = 3.5
#var checkrandom = true
var sealcheck = false


func _ready() -> void:
	$AttackTime.start()
	$AnimatedSprite2D.play("Idle")


func _on_attack_time_timeout() -> void:
	randommove = Moveset.pick_random()
	#print(target.position.x)
	#print(position.x)
	if !sealcheck:
		if target != null:
			if randommove == "Attack1":
				position = target.global_position
				$AnimatedSprite2D.play(randommove)
				await get_tree().create_timer(0.6).timeout
				$Hit/Attack1.disabled = false
				await get_tree().create_timer(0.2).timeout
				$Hit/Attack1.disabled = true
				await $AnimatedSprite2D.animation_finished
			
			elif randommove == "AttackWhole":
				if (position.x > target.position.x):
					$AnimatedSprite2D.play("AttackWhole")
					await $AnimatedSprite2D.animation_finished
					$Hit/AnimatedSprite2D2.position.x = -4075.0
					$Hit/AnimatedSprite2D2.set_frame_and_progress(0, 0)
					$Hit/AnimatedSprite2D2.flip_h = true
					$Hit/AnimatedSprite2D2.play("AttackWhole")
					$Hit/AnimatedSprite2D2.show()
					
					await $Hit/AnimatedSprite2D2.animation_finished
					$Hit/Attack2.disabled = false
					await get_tree().create_timer(0.05).timeout
					$Hit/Attack2.disabled = true
					$AnimatedSprite2D.play_backwards("AttackWhole")
					await $AnimatedSprite2D.animation_finished
					
				elif (position.x < target.position.x):
					$AnimatedSprite2D.flip_h = true
					$AnimatedSprite2D.play("AttackWhole")
					await $AnimatedSprite2D.animation_finished
					$Hit/AnimatedSprite2D2.position.x = 4075.0
					$Hit/AnimatedSprite2D2.set_frame_and_progress(0, 0)
					$Hit/AnimatedSprite2D2.flip_h = false
					$Hit/AnimatedSprite2D2.play("AttackWhole")
					$Hit/AnimatedSprite2D2.show()
					
					await $Hit/AnimatedSprite2D2.animation_finished
					$Hit/Attack3.disabled = false
					await get_tree().create_timer(0.05).timeout
					$Hit/Attack3.disabled = true
					$AnimatedSprite2D.play_backwards("AttackWhole")
					await $AnimatedSprite2D.animation_finished
					$AnimatedSprite2D.flip_h = false
				
			elif randommove == "Attack4":
				position = target.global_position
				$AnimatedSprite2D.play(randommove)
				await get_tree().create_timer(1).timeout
				$Hit/Attack4.disabled = false
				await get_tree().create_timer(0.2).timeout
				$Hit/Attack4.disabled = true
				await $AnimatedSprite2D.animation_finished
			
			$AnimatedSprite2D.play("Idle")
			$Hit/AnimatedSprite2D2.hide()
			$CooldownMove.start()
	else:
		return

func _on_change_phase_timeout() -> void:
	#print("hello")
	Moveset.append("Attack4")
	cooldown = 1.5
	changePhase.emit()
	

func _on_hit_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("attackByPlayer"):
		hp -= area.damage
		return

func _on_cooldown_move_timeout() -> void:
	$AttackTime.start()

var counttower = 3

func _on_node_2d_tower_power_on() -> void:
	counttower += 1
	if counttower >= 4:
		sealcheck = true
		$AttackTime.stop()
		$CooldownMove.stop()
		var deathtween = create_tween()
		deathtween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
		deathtween.tween_property($".", "position", Vector2(625,275), 2)
		await deathtween.finished
		get_tree().paused = true
		var scaletween = create_tween()
		scaletween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
		scaletween.tween_property(self, "scale", Vector2(0.14, 0.14), 2)
		await scaletween.finished
		scaletween.tween_property(self, "scale", Vector2(0, 0), 2)
		self.queue_free()
		
		$"../UI/Interface/CanvasLayer".hide()
		$"../Player/Camera2D".enabled = false
		$"../Sprite2D".visible = false
		Bossclean.bosswin()
		Bossclean.death = true
		var loading_scene = preload("res://Scene/load/LoadingScreen.tscn").instantiate()
		loading_scene.target_scene = "res://Scene/UI/select-door.tscn"
		get_tree().current_scene.add_child(loading_scene)
	else:
		debuffBoss()

var debuffSet = [1,2,3]

func debuffBoss():
	var randomvar = debuffSet.pick_random()
	debuffSet.remove_at(debuffSet.find(randomvar))
	if randomvar == 1:
		Moveset.remove_at(Moveset.find(Moveset.pick_random()))
	elif randomvar == 2:
		cooldown = 8
	elif randomvar == 3:
		Moveset.remove_at(Moveset.find(Moveset.pick_random()))

#func _process(delta: float) -> void:
	#if sealcheck:
		#var direction = Vector2(625,300) - global_position
		#velocity = direction.normalized() * 20 
		#$Body.disabled = true
		#move_and_slide()
		
		
