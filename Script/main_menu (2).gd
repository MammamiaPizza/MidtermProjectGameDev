extends Control


func _on_button_pressed() -> void:
	
	var loading_scene = preload("res://Scene/load/LoadingScreen.tscn").instantiate()
	$CanvasLayer.visible = false

	loading_scene.target_scene = "res://Scene/UI/select-door.tscn"
	get_tree().current_scene.add_child(loading_scene)
	pass


func _on_button_3_pressed() -> void:
	get_tree().quit()
