extends Node
var death = false
var time = false
var dimensionboss = false
var life = false
var bossdie = 0

var winscene = preload("res://Scene/UI/Win.tscn").instantiate()
var lose = preload("res://Scene/UI/lose.tscn").instantiate()

func reset():
	bossdie = 0

func getbossdie():
	return bossdie

func bosswin():
	bossdie += 1

func getd():
	return death
func gett():
	return time
func getdi():
	return dimensionboss
func getl():
	return life

func whenDead():
	get_tree().current_scene.add_child(lose)
	await get_tree().create_timer(5).timeout
	get_tree().current_scene.remove_child(lose)
	
func whenWin():
	get_tree().current_scene.add_child(winscene)
