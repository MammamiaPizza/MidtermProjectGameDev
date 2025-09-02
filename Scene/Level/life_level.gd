extends Node2D

var merge : bool


func checkmerge():
	if $Life0_5_2.merge == $Life0_5_1.merge:
		merge = true
		await get_tree().create_timer(2).timeout
		var tween1 = create_tween()
		tween1.tween_property($Life0_5_1, "position", Vector2(625,250), 2)
		var tween2 = create_tween()
		tween2.tween_property($"Life0_5_2", "position", Vector2(625,250), 2)
		await tween1.finished and tween2.finished
		
		$"Life0_5-2".free()
		$Life0_5_1.free()
		
		#await tween1.finished
		
		
