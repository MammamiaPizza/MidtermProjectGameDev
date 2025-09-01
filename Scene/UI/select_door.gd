extends Node2D

@onready var camera = $Camera2D

var move_speed = 200 # pixels per second
var move_dir = 0 # -1 = left, 1 = right, 0 = stop

func _process(delta):
	if move_dir != 0:
		camera.position.x += move_dir * move_speed * delta
		# ข้อจำกัดขอบซ้าย-ขวา
		camera.position.x = clamp(camera.position.x, -2237, 2085)

func _on_area_2d_mouse_entered() -> void: # right
	print("onright")
	move_dir = -1

func _on_area_2d_mouse_exited() -> void:
	move_dir = 0

func _on_area_2d_2_mouse_entered() -> void: # left
	print("onleft")
	move_dir = 1

func _on_area_2d_2_mouse_exited() -> void:
	move_dir = 0


func _on_area_2d_3_area_entered(area: Area2D) -> void:
	if area.is_in_group("door"):
		$AnimatedSprite2D.play("preopen")
		$AnimatedSprite2D2.play("preopen")
		$AnimatedSprite2D3.play("preopen")
		$AnimatedSprite2D4.play("preopen")

	pass # Replace with function body.


func _on_area_2d_3_area_exited(area: Area2D) -> void:
	if area.is_in_group("door"):
		$AnimatedSprite2D.play_backwards("preopen")
		$AnimatedSprite2D2.play_backwards("preopen")
		$AnimatedSprite2D3.play_backwards("preopen")
		$AnimatedSprite2D4.play_backwards("preopen")


func deathdoor() -> void:
	 # Replace with function body.
	var loading_scene = preload("res://Scene/load/LoadingScreen.tscn").instantiate()

	loading_scene.target_scene = "res://Scene/Level/DeadLevel.tscn"
	get_tree().current_scene.add_child(loading_scene)
	pass

func lifedoor() -> void:
	 # Replace with function body.
	var loading_scene = preload("res://Scene/load/LoadingScreen.tscn").instantiate()

	loading_scene.target_scene = "res://Scene/Level/LifeLevel.tscn"
	get_tree().current_scene.add_child(loading_scene)
	pass

func dimensiondoor() -> void:
	var loading_scene = preload("res://Scene/load/LoadingScreen.tscn").instantiate()
	$CanvasLayer.visible = false

	loading_scene.target_scene = "res://Scene/Level/DimensionLevel.tscn"
	get_tree().current_scene.add_child(loading_scene)
	pass # Replace with function body.


func timedoor() -> void:
	var loading_scene = preload("res://Scene/load/LoadingScreen.tscn").instantiate()
	$CanvasLayer.visible = false

	loading_scene.target_scene = "res://Scene/UI/MainMenu.tscn"
	get_tree().current_scene.add_child(loading_scene)
	pass # Replace with function body.


func _on_audio_stream_player_finished() -> void:
	$AudioStreamPlayer.play()
