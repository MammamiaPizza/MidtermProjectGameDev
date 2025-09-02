extends Node2D

func rotateevery(x) -> void:
	#$TileMapLayer3.rotate(x*90)
	#$Sprite2D2.rotate(x*90)
	
	var tween1 = create_tween()
	tween1.tween_property($TileMapLayer3, "rotation", x * 1, 180)

	var tween2 = create_tween()
	tween2.tween_property($Sprite2D2, "rotation", x * 1, 180)
