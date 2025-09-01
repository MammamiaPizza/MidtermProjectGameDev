extends Node2D
func rotateevery(x) -> void:
	$TileMapLayer3.rotate(x*90)
	$Sprite2D2.rotate(x*90)
