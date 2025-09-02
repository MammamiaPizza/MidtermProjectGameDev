extends Node2D

var towerScene = preload("res://Scene/Boss/Tower.tscn")

signal towerPowerOn
signal operatorhelp

var changePhase = false

var tower = towerScene.instantiate()
var tower2 = towerScene.instantiate()
var tower3 = towerScene.instantiate()
var tower4 = towerScene.instantiate()
var camera = Camera2D.new()
var cameratween

func _on_dead_change_phase() -> void:
	if $Player != null:
		$UI/Operater/CanvasLayer.set_visible(true)
		$UI/Operater/CanvasLayer/AnimationPlayer.play("Conver")
		$UI/Operater/CanvasLayer/AudioStreamPlayer.play()
		await $UI/Operater/CanvasLayer/AnimationPlayer.animation_finished
		await get_tree().create_timer(3).timeout
		$UI/Operater/CanvasLayer/AnimationPlayer.play_backwards("Conver")
		await $UI/Operater/CanvasLayer/AnimationPlayer.animation_finished
		$UI/Operater/CanvasLayer.set_visible(false)
		$UI/Interface/CanvasLayer.hide()
		camera.zoom = Vector2(1.3,1.3)
		$UI/CanvasLayer/VideoStreamPlayer.paused = false
		get_tree().paused = true
		changePhase = true
		playvideo()
		await get_tree().create_timer(1).timeout
		createTower()
		cameratween = create_tween()
		cameratween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
		get_node(tower.get_path()).add_child(camera)
		camera.make_current()
		cameratween.tween_property(tower, "position", $TowerLocate.position, 3)
		await cameratween.finished
		get_node(tower.get_path()).remove_child(camera)
		cameratween.kill()
		
		cameratween = create_tween()
		cameratween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
		get_node(tower2.get_path()).add_child(camera)
		camera.make_current()
		cameratween.tween_property(tower2, "position", $TowerLocate2.position, 2.5)
		await cameratween.finished
		get_node(tower2.get_path()).remove_child(camera)
		cameratween.kill()
		
		cameratween = create_tween()
		cameratween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
		get_node(tower3.get_path()).add_child(camera)
		camera.make_current()
		cameratween.tween_property(tower3, "position", $TowerLocate3.position, 2.5)
		await cameratween.finished
		get_node(tower3.get_path()).remove_child(camera)
		cameratween.kill()
		
		cameratween = create_tween()
		cameratween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
		get_node(tower4.get_path()).add_child(camera)
		camera.make_current()
		cameratween.tween_property(tower4, "position", $TowerLocate4.position, 2.5)
		await cameratween.finished
		cameratween.kill()
		cameratween = create_tween()
		cameratween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
		cameratween.tween_property(camera, "global_transform", $Player/Camera2D.global_transform, 3.5)
		await cameratween.finished
		print("after4")
		$UI/Interface/CanvasLayer.show()
		$Player/Camera2D.make_current()
		get_tree().paused = false
	

func createTower():
	add_child(tower)
	tower.scale = $Dead.scale
	tower.position = Vector2(-500,-500)
	#tower.setTarget($TowerLocate.position)
	add_child(tower2)
	tower2.scale = $Dead.scale
	tower2.position = Vector2(2000,-500)
	#tower2.setTarget($TowerLocate2.position)
	add_child(tower3)
	tower3.scale = $Dead.scale
	tower3.position = Vector2(-500,500)
	#tower3.setTarget($TowerLocate3.position)
	add_child(tower4)
	tower4.scale = $Dead.scale
	tower4.position = Vector2(2000,500)
	#tower4.setTarget($TowerLocate4.position)
	
func TowerOpen():
	#print("Hello")
	towerPowerOn.emit()

func playvideo():
	$UI/CanvasLayer/VideoStreamPlayer.show()
	$UI/CanvasLayer/VideoStreamPlayer.play()
	await  $UI/CanvasLayer/VideoStreamPlayer.finished
	$UI/CanvasLayer/VideoStreamPlayer.stop()
	$UI/CanvasLayer/VideoStreamPlayer.hide()

func operaterhelp():
	$UI/Operater.show()
