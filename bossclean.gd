extends Node
var death = false
var time = false
var dimension = false
var life = false
var bossdie = 0

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
	return dimension
func getl():
	return life
