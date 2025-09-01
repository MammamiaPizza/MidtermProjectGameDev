extends Node2D

var towerScene = preload("res://Scene/Boss/Tower.tscn")

signal towerPowerOn

var changePhase = false

var tower = towerScene.instantiate()
var tower2 = towerScene.instantiate()
var tower3 = towerScene.instantiate()
var tower4 = towerScene.instantiate()


func _on_dead_change_phase() -> void:
	get_tree().paused = true
	changePhase = true
	createTower()
	await get_tree().create_timer(2).timeout
	get_tree().paused = false
	

func createTower():
	add_child(tower)
	tower.scale = $Dead.scale
	tower.position = Vector2(-500,-500)
	tower.setTarget($TowerLocate.position)
	add_child(tower2)
	tower2.scale = $Dead.scale
	tower2.position = Vector2(2000,-500)
	tower2.setTarget($TowerLocate2.position)
	add_child(tower3)
	tower3.scale = $Dead.scale
	tower3.position = Vector2(-500,500)
	tower3.setTarget($TowerLocate3.position)
	add_child(tower4)
	tower4.scale = $Dead.scale
	tower4.position = Vector2(2000,500)
	tower4.setTarget($TowerLocate4.position)
	
	
func TowerOpen():
	#print("Hello")
	towerPowerOn.emit()
