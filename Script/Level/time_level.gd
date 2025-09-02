extends Node2D
#func _ready() -> void:
	##$AudioStreamPlayer2D.set_loop(true)
	#$AudioStreamPlayer2D.


func _on_player_death() -> void:
	$UI/Interface/CanvasLayer.hide()	
	
