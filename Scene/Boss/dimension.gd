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
var sealcheck = false


func _ready() -> void:
	$AttackTime.start()
	$body.play("Idle")


func _on_attack_time_timeout() -> void:
	randommove = Moveset.pick_random()
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
			await $AnimatedSprite2D.animation_finished
		
		elif randommove == "Attack2":
			if (position.x > target.position.x):
				$body.play("warp")
				await $body.animation_finished
				position.x = target.global_position.x+100
				position.y = target.global_position.y
				$body.play_backwards("warp")
				await $body.animation_finished
				$body.play("Attack2")
				await $body.animation_finished
				$Hit/Attack2.set_frame_and_progress(0, 0)
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
				$body.play("Attack3")
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

func _on_change_phase_timeout() -> void:
	#print("hello")
	Moveset.append("Attack4")
	cooldown = 1.5
	changePhase.emit()

func _on_hit_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("attackByPlayer"):
		hp -= area.damage

func _on_cooldown_move_timeout() -> void:
	$AttackTime.start()

var counttower = 0

func _on_node_2d_tower_power_on() -> void:
	counttower += 1
	if counttower >= 4:
		sealcheck = true
		$AttackTime.stop()
		$CooldownMove.stop()
		var scaletween = create_tween()
		scaletween.tween_property(self, "scale", Vector2(0.14, 0.14), 2)
		await scaletween.finished
		scaletween.tween_property(self, "scale", Vector2(0, 0), 2)
		self.queue_free()
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

func _process(delta: float) -> void:
	if sealcheck:
		var direction = Vector2(625,300) - global_position
		velocity = direction.normalized() * 20 
		$Body.disabled = true
		move_and_slide()
		
