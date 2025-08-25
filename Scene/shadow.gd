extends Sprite2D

func _ready() -> void:
	fadeout()

func fadeout() -> void:
	var tween = get_tree().create_tween()
	
	tween.tween_property(self, "self_modulate", Color(1,1,1,0), 0.75)
	await tween.finished
	
	queue_free()
