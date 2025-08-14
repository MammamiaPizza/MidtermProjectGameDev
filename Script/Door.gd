extends Node2D

@export var nextscene : PackedScene


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		get_tree().change_scene_to_packed(nextscene)
