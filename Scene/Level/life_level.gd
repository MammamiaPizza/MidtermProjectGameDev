extends Node2D

var merge : bool

var lifemerge = preload("res://Scene/Boss/Life.tscn").instantiate()


func checkmerge():
	if $Life0_5_2.merge == $Life0_5_1.merge:
		merge = true
		await get_tree().create_timer(2).timeout
		var tween1 = create_tween()
		tween1.tween_property($Life0_5_1, "position", Vector2(625,250), 2)
		var tween2 = create_tween()
		tween2.tween_property($"Life0_5_2", "position", Vector2(625,250), 2)
		var tweencolor1 = create_tween()
		var tweencolor2 = create_tween()
		tweencolor1.tween_property($Life0_5_1/AnimatedSprite2D.get_mate, "shader_parameter/flashEnabled", 1, 2)
		tweencolor2.tween_property($"Life0_5_2", "shader_parameter/flashEnabled", 1, 2)
		await tween1.finished and tween2.finished
		tween1.kill()
		tween2.kill()
		$Life0_5_2.free()
		$Life0_5_1.free()
		add_child(lifemerge)
		lifemerge.position = Vector2(625,250)
		lifemerge.scale = Vector2(0.5,0.5)
		$UI.setLifeMerge(lifemerge)
	$Player	
		
func _process(delta: float) -> void:
	if $Player != null:
		$Player.hp -= 1 * delta
