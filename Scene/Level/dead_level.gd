extends Node2D

var towerScene = preload("res://Scene/Boss/Tower.tscn")

var changePhase = true

var tower = towerScene.instantiate()
var tower2 = towerScene.instantiate()
var tower3 = towerScene.instantiate()
var tower4 = towerScene.instantiate()


func _ready() -> void:
	testcreateitem()

func _on_dead_change_phase() -> void:
	changePhase == true
	

func testcreateitem():
	#get_node("Dead").add_child(tower)
	#get_node("Dead").add_child(tower2)
	get_tree().current_scene.add_child(tower)
	tower.position = Vector2.ZERO
	
func _process(delta: float) -> void:
