extends Node2D

var merge : bool

var lifemerge = preload("res://Scene/Boss/Life.tscn").instantiate()

var hp = 1000

var plus = false
var cameranew = Camera2D.new()

func checkmerge():
	if $Life0_5_2.merge == $Life0_5_1.merge:
		merge = true
		var cameratween = create_tween()
		get_node("Player").add_child(cameranew)
		cameranew.zoom = $Player/Camera2D.get_zoom()
		cameranew.make_current()
		cameratween.tween_property(cameranew, "global_transform", $Marker2D.global_transform, 1)
		await cameratween.finished
		$Marker2D/Camera2D.make_current()
		get_node("Player").remove_child(cameranew)
		cameratween.kill()
		$Phase1.stop()
		await get_tree().create_timer(2).timeout
		var tween1 = create_tween()
		tween1.tween_property($Life0_5_1, "position", Vector2(625,300), 2)
		var tween2 = create_tween()
		tween2.tween_property($"Life0_5_2", "position", Vector2(625,300), 2)
		var tweencolor1 = create_tween()
		var tweencolor2 = create_tween()
		tweencolor1.tween_property($Life0_5_1/AnimatedSprite2D.material, "shader_parameter/flashEnabled", 1, 1 )
		tweencolor2.tween_property($Life0_5_2/AnimatedSprite2D.material, "shader_parameter/flashEnabled", 1, 1 )
		await tween1.finished and tween2.finished
		$Phase2.play()
		tween1.kill()
		tweencolor1.kill()
		tween2.kill()
		tweencolor2.kill()
		$Life0_5_2.queue_free()
		$Life0_5_1.queue_free()
		
		get_tree().paused = true
		add_child(lifemerge)
		lifemerge.position = Vector2(625,250)
		lifemerge.scale = Vector2(0.5,0.5)
		var mergelife = create_tween()
		mergelife.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
		var lifemergeAnimated = get_node(lifemerge.get_node("AnimatedSprite2D").get_path())
		mergelife.tween_property(lifemergeAnimated.material, "shader_parameter/flashEnabled", 0, 4.5)
		await mergelife.finished
		mergelife.kill()
		
		var camerafrommarker = Camera2D.new()
		get_node("Marker2D").add_child(camerafrommarker)
		camerafrommarker.zoom = $Marker2D/Camera2D.zoom
		camerafrommarker.make_current()
		cameratween = create_tween()
		cameratween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
		cameratween.tween_property(camerafrommarker, "global_transform", $Player.global_transform, 5)
		await cameratween.finished
		$Player/Camera2D.make_current()
		cameratween.kill()
		get_tree().paused = false
		
		
		
		
		$UI.setLifeMerge(lifemerge)
		
func _process(delta: float) -> void:
	if get_node_or_null("Player") != null:
		#print($Player.hp)
		if plus:
			$Player.hp += 1 * delta
		else:
			$Player.hp -= 1 * delta
	else:
		return


func _on_timer_timeout() -> void:
	plus = !plus
	if !plus:
		$UI/Interface/CanvasLayer/TextureProgressBar2.set_tint_progress(Color(0,0,0))
	else:
		$UI/Interface/CanvasLayer/TextureProgressBar2.set_tint_progress(Color(255,255,255))
	$Cooldown.start()
		


func _on_cooldown_timeout() -> void:
	$Change.start()


func _on_player_death() -> void:
	$UI/Interface/CanvasLayer.hide()
	$UI/Operater/CanvasLayer.hide()	
	$UI/Operater/CanvasLayer/AnimationPlayer.stop()
