extends StaticBody2D

var hp : int = 5000

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("attaclByPlayer"):
		hp -= area.
		
