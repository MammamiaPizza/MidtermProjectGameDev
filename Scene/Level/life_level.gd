extends Node2D

var merge : bool


func checkmerge():
	if $"Life0_5-2".merge == $Life0_5_1.merge:
		merge = true
		


func _process(delta: float) -> void:
	
