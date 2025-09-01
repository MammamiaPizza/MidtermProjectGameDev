extends Control


func _on_button_pressed() -> void:
	
	var loading_scene = preload("res://Scene/load/LoadingScreen.tscn").instantiate()
	$CanvasLayer.visible = false

	loading_scene.target_scene = "res://Scene/UI/Setting.tscn"
	get_tree().current_scene.add_child(loading_scene)
	pass
