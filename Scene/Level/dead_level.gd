extends Node2D

var towerScene = preload("res://Scene/Boss/Tower.tscn")

signal towerPowerOn

var changePhase = false

var tower = towerScene.instantiate()
var tower2 = towerScene.instantiate()
var tower3 = towerScene.instantiate()
var tower4 = towerScene.instantiate()

func _ready() -> void:
	createTower()

func _on_dead_change_phase() -> void:
	get_tree().paused = true
	changePhase = true
	createTower()
	

func createTower():
	add_child(tower)
	tower.scale = $Dead.scale
	tower.position = Vector2(-500,-500)
	add_child(tower2)
	tower2.scale = $Dead.scale
	tower2.position = Vector2(2000,-500)
	add_child(tower3)
	tower3.scale = $Dead.scale
	tower3.position = Vector2(-500,500)
	add_child(tower4)
	tower4.scale = $Dead.scale
	tower4.position = Vector2(2000,500)
	
func _process(delta: float) -> void:
	if changePhase:
		var direction1 = $TowerLocate.position - tower.position
		tower.position += direction1 * delta
		var direction2 = $TowerLocate2.position - tower2.position
		tower2.position += direction2 * delta
		var direction3 = $TowerLocate3.position - tower3.position
		tower3.position += direction3 * delta
		var direction4 = $TowerLocate4.position - tower4.position
		tower4.position += direction4 * delta
