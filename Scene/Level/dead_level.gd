extends Node2D


func _on_dead_change_phase() -> void:
	get_tree().paused
