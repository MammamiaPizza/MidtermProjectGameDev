extends Control

var loading_scene = preload("res://Scene/load/LoadingScreen.tscn").instantiate()

func _on_button_pressed() -> void:
	$CanvasLayer/Label.free()
	$CanvasLayer/Button.hide()
	
	loading_scene.target_scene = "res://Scene/UI/select-door.tscn"
	get_tree().current_scene.add_child(loading_scene)
